import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/menu_item.dart';

class OrderService {
  final _db = FirebaseFirestore.instance;

  /// Submits one round of items for [tableId]. This does NOT check the
  /// customer out — it's one entry in their running tab. They can keep
  /// calling this again later in the same visit.
  Future<String> submitOrder({
    required String tableId,
    required List<CartLine> cart,
    String? customerPhone,
  }) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    final orderRef = await _db.collection('orders').add({
      'table_id': tableId,
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
      'status': 'pending', // pending -> preparing -> ready -> served
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

  /// All order rounds placed by this table, newest first. This is the
  /// customer's running tab for the current visit.
  Stream<List<Map<String, dynamic>>> watchTableOrders(String tableId) {
    return _db
        .collection('orders')
        .where('table_id', isEqualTo: tableId)
        .orderBy('created_at', descending: true)
        .snapshots()
        .map((snap) => snap.docs
        .map((doc) => {'id': doc.id, ...doc.data()})
        .toList());
  }

  /// Whether this table currently has an open (unresolved) bill request.
  /// Once staff settles the tab (from the POS/admin side), that side would
  /// mark this request 'settled' and a fresh visit can start a new one.
  Stream<bool> watchBillRequested(String tableId) {
    return _db
        .collection('bill_requests')
        .where('table_id', isEqualTo: tableId)
        .where('status', isEqualTo: 'requested')
        .snapshots()
        .map((snap) => snap.docs.isNotEmpty);
  }

  /// Customer asks to close out their tab. Staff/POS sees this and brings
  /// the bill — it does not itself mark anything as paid.
  Future<void> requestBill(String tableId) async {
    await _db.collection('bill_requests').add({
      'table_id': tableId,
      'status': 'requested',
      'requested_at': FieldValue.serverTimestamp(),
    });
  }
}
