import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/menu_item.dart';

class OrderService {
  final _db = FirebaseFirestore.instance;

  /// Submits one round of items for [tableId] under the current
  /// [sessionId]. Tagging every write with the session is what makes a
  /// fresh scan a genuinely clean slate — a new session simply can't see
  /// a previous (possibly paid-off) session's orders, bill requests, or
  /// assistance calls, without needing anything to explicitly "reset".
  Future<String> submitOrder({
    required String tableId,
    required String sessionId,
    required List<CartLine> cart,
    String? customerPhone,
  }) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    final orderRef = await _db.collection('orders').add({
      'table_id': tableId,
      'session_id': sessionId,
      'customer_uid': uid,
      'customer_phone': customerPhone,
      'items': cart
          .map((line) => {
        'item_id': line.item.id,
        'name': line.item.name,
        'price': line.item.price,
        'quantity': line.quantity,
        'note': line.note,
      })
          .toList(),
      'total': cart.fold<double>(0, (sum, line) => sum + line.subtotal),
      'status': 'pending', // pending -> preparing -> ready -> served -> paid
      'created_at': FieldValue.serverTimestamp(),
    });

    return orderRef.id;
  }

  /// Live menu items, filtered to what's currently available.
  Stream<List<MenuItem>> watchMenu() {
    return _db
        .collection('menu_items')
        .where('available', isEqualTo: true)
        .snapshots()
        .map((snap) => snap.docs
        .map((doc) => MenuItem.fromFirestore(doc.id, doc.data()))
        .toList());
  }

  /// This session's order rounds only, newest first. Queries by table_id
  /// (reusing the existing composite index with created_at) and filters
  /// down to the current session client-side, so an old session's paid-off
  /// orders never bleed into a new visit's tab.
  Stream<List<Map<String, dynamic>>> watchTableOrders(String tableId, String sessionId) {
    return _db
        .collection('orders')
        .where('table_id', isEqualTo: tableId)
        .orderBy('created_at', descending: true)
        .snapshots()
        .map((snap) => snap.docs
        .map((doc) => {'id': doc.id, ...doc.data()})
        .where((data) => data['session_id'] == sessionId)
        .toList());
  }

  /// Whether THIS session currently has an open (unresolved) bill request.
  /// Nothing ever flips bill_requests.status away from 'requested' once
  /// staff settle up — so this alone would stay stuck "paused" forever
  /// even after payment. Use watchOrderingPaused below for the actual
  /// UI-facing lock instead of this on its own.
  Stream<bool> watchBillRequested(String tableId, String sessionId) {
    return _db
        .collection('bill_requests')
        .where('table_id', isEqualTo: tableId)
        .where('status', isEqualTo: 'requested')
        .snapshots()
        .map((snap) => snap.docs.any((d) => d.data()['session_id'] == sessionId));
  }

  /// The actual "new orders are paused" state: true only while a bill has
  /// been requested AND at least one of this session's orders still isn't
  /// paid. The moment POS marks everything paid, this clears live — no
  /// reload needed. Genuinely combines both streams (not just re-checking
  /// one when the other changes), so an order flipping to 'paid' updates
  /// this immediately even though that's a different collection than
  /// bill_requests.
  Stream<bool> watchOrderingPaused(String tableId, String sessionId) {
    late StreamController<bool> controller;
    StreamSubscription? billSub;
    StreamSubscription? ordersSub;
    bool? lastBillRequested;
    List<Map<String, dynamic>>? lastOrders;

    void emit() {
      if (lastBillRequested == null) return;
      if (!lastBillRequested!) {
        controller.add(false);
        return;
      }
      final orders = lastOrders ?? [];
      if (orders.isEmpty) {
        controller.add(true); // requested with nothing placed yet — stay paused
        return;
      }
      final allPaid = orders.every((o) => o['status'] == 'paid');
      controller.add(!allPaid);
    }

    controller = StreamController<bool>(
      onListen: () {
        billSub = watchBillRequested(tableId, sessionId).listen((v) {
          lastBillRequested = v;
          emit();
        });
        ordersSub = watchTableOrders(tableId, sessionId).listen((v) {
          lastOrders = v;
          emit();
        });
      },
      onCancel: () {
        billSub?.cancel();
        ordersSub?.cancel();
      },
    );

    return controller.stream;
  }

  /// Customer asks to close out their tab. Staff/POS sees this and brings
  /// the bill — it does not itself mark anything as paid.
  Future<void> requestBill(String tableId, String sessionId) async {
    await _db.collection('bill_requests').add({
      'table_id': tableId,
      'session_id': sessionId,
      'status': 'requested',
      'requested_at': FieldValue.serverTimestamp(),
    });
  }

  /// Whether THIS session currently has an open (unresolved) assistance request.
  Stream<bool> watchAssistanceRequested(String tableId, String sessionId) {
    return _db
        .collection('assistance_requests')
        .where('table_id', isEqualTo: tableId)
        .where('status', isEqualTo: 'requested')
        .snapshots()
        .map((snap) => snap.docs.any((d) => d.data()['session_id'] == sessionId));
  }

  /// Most recent assistance request time for THIS session — used to
  /// enforce the client-side spam cooldown.
  Stream<DateTime?> watchLastAssistanceRequestTime(String tableId, String sessionId) {
    return _db
        .collection('assistance_requests')
        .where('table_id', isEqualTo: tableId)
        .snapshots()
        .map((snap) {
      DateTime? latest;
      for (final doc in snap.docs) {
        if (doc.data()['session_id'] != sessionId) continue;
        final ts = doc.data()['requested_at'] as Timestamp?;
        if (ts == null) continue;
        final dt = ts.toDate();
        if (latest == null || dt.isAfter(latest)) latest = dt;
      }
      return latest;
    });
  }

  /// Customer taps "Ask for assistance" — e.g. needs a staff member at the
  /// table for something that isn't an order or the bill.
  Future<void> requestAssistance(String tableId, String sessionId) async {
    await _db.collection('assistance_requests').add({
      'table_id': tableId,
      'session_id': sessionId,
      'status': 'requested',
      'requested_at': FieldValue.serverTimestamp(),
    });
  }
}
