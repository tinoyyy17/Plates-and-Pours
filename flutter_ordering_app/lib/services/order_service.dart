import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/menu_item.dart';

class OrderService {
  final _db = FirebaseFirestore.instance;

  /// Submits an order for a given [tableId]. This is the field the
  /// admin/kitchen dashboard reads to know which table placed it —
  /// no extra "detection" needed, it's just carried from the QR URL.
  Future<String> submitOrder({
    required String tableId,
    required List<CartLine> cart,
    String? customerPhone, // used to link loyalty points, optional for guests
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
}
