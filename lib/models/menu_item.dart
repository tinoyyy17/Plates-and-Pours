class MenuItem {
  final String id;
  final String name;
  final double price;
  final String category;
  final String? imageUrl;
  final String? description;
  final List<String> ingredients;
  final bool available;
  final double ratingSum;
  final int ratingCount;
  final int soldCount;

  MenuItem({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    this.imageUrl,
    this.description,
    this.ingredients = const [],
    this.available = true,
    this.ratingSum = 0,
    this.ratingCount = 0,
    this.soldCount = 0,
  });

  /// 0 when nobody's rated it yet — check [ratingCount] before showing
  /// this rather than displaying a misleading "0.0 stars".
  double get avgRating => ratingCount == 0 ? 0 : ratingSum / ratingCount;

  factory MenuItem.fromFirestore(String id, Map<String, dynamic> data) {
    return MenuItem(
      id: id,
      name: data['name'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      category: data['category'] ?? 'Uncategorized',
      imageUrl: data['image_url'],
      description: data['description'],
      ingredients: List<String>.from(data['ingredients'] ?? const []),
      available: data['available'] ?? true,
      ratingSum: ((data['rating_sum'] ?? 0) as num).toDouble(),
      ratingCount: ((data['rating_count'] ?? 0) as num).toInt(),
      soldCount: ((data['sold_count'] ?? 0) as num).toInt(),
    );
  }
}

/// A single line in the cart. Two lines with the same item but different
/// notes are kept separate on purpose — "no ice" and a plain order of the
/// same drink shouldn't merge into one line.
class CartLine {
  final MenuItem item;
  int quantity;
  final String note;

  CartLine({required this.item, this.quantity = 1, this.note = ''});

  double get subtotal => item.price * quantity;
}
