class MenuItem {
  final String id;
  final String name;
  final double price;
  final String category;
  final String? imageUrl;
  final bool available;

  MenuItem({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    this.imageUrl,
    this.available = true,
  });

  factory MenuItem.fromFirestore(String id, Map<String, dynamic> data) {
    return MenuItem(
      id: id,
      name: data['name'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      category: data['category'] ?? 'Uncategorized',
      imageUrl: data['image_url'],
      available: data['available'] ?? true,
    );
  }
}

class CartLine {
  final MenuItem item;
  int quantity;

  CartLine({required this.item, this.quantity = 1});

  double get subtotal => item.price * quantity;
}
