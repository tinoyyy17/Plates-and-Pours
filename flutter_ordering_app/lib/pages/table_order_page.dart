import 'package:flutter/material.dart';
import '../models/menu_item.dart';
import '../services/order_service.dart';

class TableOrderPage extends StatefulWidget {
  const TableOrderPage({super.key});

  @override
  State<TableOrderPage> createState() => _TableOrderPageState();
}

class _TableOrderPageState extends State<TableOrderPage> {
  final _orderService = OrderService();
  final List<CartLine> _cart = [];
  late final String _tableId;

  @override
  void initState() {
    super.initState();
    // Reads ?table=3 from the browser URL. This is what makes the QR
    // code per-table: each printed code just has a different value here.
    _tableId = Uri.base.queryParameters['table'] ?? 'unknown';
  }

  void _addToCart(MenuItem item) {
    setState(() {
      final existing = _cart.where((l) => l.item.id == item.id).firstOrNull;
      if (existing != null) {
        existing.quantity++;
      } else {
        _cart.add(CartLine(item: item));
      }
    });
  }

  double get _cartTotal => _cart.fold(0, (sum, l) => sum + l.subtotal);

  Future<void> _submitOrder() async {
    if (_cart.isEmpty) return;
    final orderId = await _orderService.submitOrder(
      tableId: _tableId,
      cart: _cart,
    );
    if (!mounted) return;
    setState(() => _cart.clear());
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Order placed! Ref: $orderId')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Table $_tableId · Plates & Pours')),
      body: StreamBuilder<List<MenuItem>>(
        stream: _orderService.watchMenu(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final menu = snapshot.data!;
          return ListView.builder(
            itemCount: menu.length,
            itemBuilder: (context, i) {
              final item = menu[i];
              return ListTile(
                title: Text(item.name),
                subtitle: Text('₱${item.price.toStringAsFixed(2)}'),
                trailing: IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () => _addToCart(item),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total: ₱${_cartTotal.toStringAsFixed(2)}'),
              ElevatedButton(
                onPressed: _cart.isEmpty ? null : _submitOrder,
                child: Text('Place order (${_cart.length})'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
