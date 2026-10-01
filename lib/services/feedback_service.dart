import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FeedbackService {
  final _db = FirebaseFirestore.instance;

  /// Whether this session has already left feedback — one submission per
  /// visit, so the "Rate your visit" prompt disappears once it's been used
  /// instead of inviting a second, duplicate rating.
  Stream<bool> watchFeedbackSubmitted(String tableId, String sessionId) {
    return _db
        .collection('feedback')
        .where('session_id', isEqualTo: sessionId)
        .snapshots()
        .map((snap) => snap.docs.isNotEmpty);
  }

  /// Writes one feedback doc (what shows up in the admin Feedback inbox —
  /// service rating, comment, and the per-dish stars given) and, in the
  /// same batch, folds each dish's stars into that menu item's running
  /// rating_sum/rating_count so the customer menu's star average updates
  /// immediately. FieldValue.increment is atomic and commutative, so this
  /// doesn't need a transaction — it can never race with itself.
  ///
  /// `rated_item_ids` mirrors the item ids from itemRatings as a flat array
  /// so a single dish's page can later find this feedback with a plain
  /// array-contains query — no composite index needed as long as we don't
  /// also orderBy a different field server-side (we sort client-side in
  /// watchItemComments instead).
  Future<void> submitFeedback({
    required String tableId,
    required String sessionId,
    required int serviceRating,
    required String comment,
    required List<Map<String, dynamic>> itemRatings, // [{item_id, item_name, stars}]
  }) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final batch = _db.batch();

    final ratedItemIds = <String>{
      for (final rating in itemRatings)
        if (rating['item_id'] != null) rating['item_id'] as String,
    }.toList();

    final feedbackRef = _db.collection('feedback').doc();
    batch.set(feedbackRef, {
      'table_id': tableId,
      'session_id': sessionId,
      'customer_uid': uid,
      'service_rating': serviceRating,
      'comment': comment,
      'item_ratings': itemRatings,
      'rated_item_ids': ratedItemIds,
      'created_at': FieldValue.serverTimestamp(),
    });

    for (final rating in itemRatings) {
      final itemId = rating['item_id'] as String?;
      final stars = (rating['stars'] as num?)?.toInt() ?? 0;
      if (itemId == null || stars <= 0) continue;
      batch.update(_db.collection('menu_items').doc(itemId), {
        'rating_sum': FieldValue.increment(stars),
        'rating_count': FieldValue.increment(1),
      });
    }

    await batch.commit();
  }

  /// The 3 most recent comments left for one specific dish. Filters to
  /// feedback docs whose rated_item_ids contains this item, then does the
  /// non-empty-comment filter, sort-by-newest and cap-to-3 client-side —
  /// keeps this to a single-field (array-contains) query so no composite
  /// index is required.
  Stream<List<Map<String, dynamic>>> watchItemComments(String itemId) {
    return _db
        .collection('feedback')
        .where('rated_item_ids', arrayContains: itemId)
        .snapshots()
        .map((snap) {
      final docs = snap.docs
          .map((d) => {'id': d.id, ...d.data()})
          .where((data) => (data['comment'] ?? '').toString().trim().isNotEmpty)
          .toList();
      docs.sort((a, b) {
        final at = a['created_at'];
        final bt = b['created_at'];
        if (at == null || bt == null) return 0;
        return (bt as dynamic).compareTo(at); // newest first
      });
      return docs.take(3).toList();
    });
  }
}
