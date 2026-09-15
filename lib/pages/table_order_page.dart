import 'package:flutter/material.dart';
import '../models/menu_item.dart';
import '../services/order_service.dart';
import '../theme/app_theme.dart';
import '../widgets/cart_sheet.dart';
import '../widgets/item_detail_sheet.dart';
import 'pending_orders_page.dart';

class TableOrderPage extends StatefulWidget {
  const TableOrderPage({super.key});

  @override
  State<TableOrderPage> createState() => _TableOrderPageState();
}

class _TableOrderPageState extends State<TableOrderPage> {
  final _orderService = OrderService();
  final List<CartLine> _cart = [];
  final _searchController = TextEditingController();
  late final String _tableId;

  String _searchQuery = '';
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _tableId = Uri.base.queryParameters['table'] ?? 'unknown';
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Quick-add from the grid's + button — default line, no note.
  void _quickAdd(MenuItem item) {
    setState(() {
      final index = _cart.indexWhere((l) => l.item.id == item.id && l.note.isEmpty);
      if (index == -1) {
        _cart.add(CartLine(item: item));
      } else {
        _cart[index].quantity++;
      }
    });
  }

  /// Add from the detail sheet, where a specific quantity/note was chosen.
  /// Lines with a different note are kept separate from plain ones.
  void _addFromDetail(MenuItem item, int quantity, String note) {
    setState(() {
      final index = _cart.indexWhere((l) => l.item.id == item.id && l.note == note);
      if (index == -1) {
        _cart.add(CartLine(item: item, quantity: quantity, note: note));
      } else {
        _cart[index].quantity += quantity;
      }
    });
  }

  void _adjustLine(CartLine line, int delta) {
    setState(() {
      line.quantity += delta;
      if (line.quantity <= 0) {
        _cart.remove(line);
      }
    });
  }

  int get _itemCount => _cart.fold(0, (sum, l) => sum + l.quantity);
  double get _cartTotal => _cart.fold(0, (sum, l) => sum + l.subtotal);

  Future<void> _submitOrder() async {
    final orderId = await _orderService.submitOrder(tableId: _tableId, cart: _cart);
    if (!mounted) return;
    Navigator.of(context).pop();
    setState(() => _cart.clear());
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Order sent to the kitchen — ref $orderId')),
    );
  }

  void _openCart() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => CartSheet(
          cart: _cart,
          onAdjust: (line, delta) {
            _adjustLine(line, delta);
            setSheetState(() {});
          },
          onSubmit: _submitOrder,
        ),
      ),
    );
  }

  void _openItemDetail(MenuItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => ItemDetailSheet(
        item: item,
        onAddToCart: (qty, note) => _addFromDetail(item, qty, note),
      ),
    );
  }

  void _openPendingOrders() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PendingOrdersPage(tableId: _tableId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return StreamBuilder<bool>(
      stream: _orderService.watchBillRequested(_tableId),
      builder: (context, billSnap) {
        final billRequested = billSnap.data ?? false;

        return Scaffold(
          body: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Container(
                  margin: const EdgeInsets.all(16),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.border),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.forest.withOpacity(0.07),
                        blurRadius: 28,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _Header(tableId: _tableId, onViewOrders: _openPendingOrders),
                      Divider(height: 1, color: AppColors.border),
                      if (billRequested)
                        Container(
                          width: double.infinity,
                          color: AppColors.gold.withOpacity(0.25),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Text(
                            'Bill requested for this table — new orders are paused until it\u2019s settled.',
                            style: text.bodySmall?.copyWith(color: AppColors.forest),
                          ),
                        ),
                      Expanded(
                        child: StreamBuilder<List<MenuItem>>(
                          stream: _orderService.watchMenu(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            final menu = snapshot.data!;
                            if (menu.isEmpty) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(32),
                                  child: Text(
                                    'The menu isn\u2019t set up yet — check back in a moment.',
                                    textAlign: TextAlign.center,
                                    style: text.bodyMedium?.copyWith(color: AppColors.forestMuted),
                                  ),
                                ),
                              );
                            }

                            final categories = <String>['All', ...{for (final m in menu) m.category}];

                            final filtered = menu.where((item) {
                              final matchesCategory =
                                  _selectedCategory == 'All' || item.category == _selectedCategory;
                              final matchesSearch = _searchQuery.isEmpty ||
                                  item.name.toLowerCase().contains(_searchQuery.toLowerCase());
                              return matchesCategory && matchesSearch;
                            }).toList();

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                                  child: Text('Menu', style: text.displaySmall?.copyWith(fontSize: 20)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                                  child: _SearchField(
                                    controller: _searchController,
                                    onChanged: (v) => setState(() => _searchQuery = v),
                                  ),
                                ),
                                SizedBox(
                                  height: 44,
                                  child: ListView.separated(
                                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: categories.length,
                                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                                    itemBuilder: (context, i) {
                                      final cat = categories[i];
                                      return _CategoryPill(
                                        label: cat,
                                        selected: cat == _selectedCategory,
                                        onTap: () => setState(() => _selectedCategory = cat),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Expanded(
                                  child: filtered.isEmpty
                                      ? Center(
                                    child: Text(
                                      'No items match your search.',
                                      style: text.bodyMedium?.copyWith(color: AppColors.forestMuted),
                                    ),
                                  )
                                      : GridView.builder(
                                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 12,
                                      crossAxisSpacing: 12,
                                      childAspectRatio: 0.62,
                                    ),
                                    itemCount: filtered.length,
                                    itemBuilder: (context, i) {
                                      final item = filtered[i];
                                      final qty = _cart
                                          .where((l) => l.item.id == item.id)
                                          .fold(0, (sum, l) => sum + l.quantity);
                                      return _MenuGridCard(
                                        item: item,
                                        quantity: qty,
                                        onTapCard: billRequested ? null : () => _openItemDetail(item),
                                        onQuickAdd: billRequested ? null : () => _quickAdd(item),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Divider(height: 1, color: AppColors.border),
                      _CartBar(
                        itemCount: _itemCount,
                        total: _cartTotal,
                        onViewCart: (_cart.isEmpty || billRequested) ? null : _openCart,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  final String tableId;
  final VoidCallback onViewOrders;

  const _Header({required this.tableId, required this.onViewOrders});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 12, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset('assets/logo.jpg', width: 52, height: 52, fit: BoxFit.cover),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Plates & Pours', style: text.displaySmall?.copyWith(fontSize: 19)),
                const SizedBox(height: 2),
                Text('Garden Resto & Café', style: text.bodySmall),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.gold,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Table $tableId',
              style: text.bodySmall?.copyWith(color: AppColors.forest, fontWeight: FontWeight.w600),
            ),
          ),
          IconButton(
            onPressed: onViewOrders,
            icon: const Icon(Icons.receipt_long, color: AppColors.forest),
            tooltip: 'Your orders',
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _SearchField({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        hintText: 'Search the menu',
        hintStyle: TextStyle(color: AppColors.forestMuted),
        prefixIcon: const Icon(Icons.search, size: 20, color: AppColors.forestMuted),
        filled: true,
        fillColor: AppColors.cardBg,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.gold, width: 1.5),
        ),
      ),
    );
  }
}

class _CategoryPill extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _CategoryPill({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.forest : AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? AppColors.forest : AppColors.border),
        ),
        child: Text(
          label,
          style: text.bodySmall?.copyWith(
            color: selected ? Colors.white : AppColors.forest,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _MenuGridCard extends StatelessWidget {
  final MenuItem item;
  final int quantity;
  final VoidCallback? onTapCard;
  final VoidCallback? onQuickAdd;

  const _MenuGridCard({
    required this.item,
    required this.quantity,
    required this.onTapCard,
    required this.onQuickAdd,
  });

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTapCard,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: AspectRatio(
                aspectRatio: 1.4,
                child: item.imageUrl == null || item.imageUrl!.isEmpty
                    ? Container(
                  color: AppColors.border.withOpacity(0.4),
                  alignment: Alignment.center,
                  child: const Icon(Icons.restaurant, color: AppColors.forestMuted, size: 22),
                )
                    : Image.network(
                  item.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: AppColors.border.withOpacity(0.4),
                    alignment: Alignment.center,
                    child: const Icon(Icons.broken_image, color: AppColors.forestMuted, size: 22),
                  ),
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Container(
                      color: AppColors.border.withOpacity(0.4),
                      alignment: Alignment.center,
                      child: const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(item.name, style: text.bodyLarge, maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 4),
            Text(item.category, style: text.bodySmall),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₱${item.price.toStringAsFixed(2)}',
                  style: text.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                InkWell(
                  onTap: onQuickAdd,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    width: 30,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: onQuickAdd == null ? AppColors.border : AppColors.gold,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, size: 16, color: AppColors.forest),
                  ),
                ),
              ],
            ),
            if (quantity > 0) ...[
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.forest,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  '$quantity in cart',
                  style: text.bodySmall?.copyWith(color: Colors.white, fontSize: 11),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _CartBar extends StatelessWidget {
  final int itemCount;
  final double total;
  final VoidCallback? onViewCart;

  const _CartBar({required this.itemCount, required this.total, required this.onViewCart});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final isEmpty = onViewCart == null;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            itemCount == 0
                ? 'Browsing as guest'
                : '$itemCount item${itemCount == 1 ? '' : 's'} · ₱${total.toStringAsFixed(2)}',
            style: text.bodyMedium,
          ),
          ElevatedButton(
            onPressed: onViewCart,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.gold,
              disabledBackgroundColor: AppColors.border,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 0,
            ),
            child: Text(isEmpty ? 'Add items to order' : 'View cart', style: text.labelLarge),
          ),
        ],
      ),
    );
  }
}
