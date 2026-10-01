import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/menu_item.dart';
import '../services/order_service.dart';
import '../theme/app_theme.dart';
import '../widgets/cart_sheet.dart';
import '../widgets/item_detail_sheet.dart';
import '../widgets/star_rating.dart';
import 'pending_orders_page.dart';
import 'profile_page.dart';

enum _SortMode { defaultOrder, bestSellers, topRated }

class TableOrderPage extends StatefulWidget {
  final String tableId;
  final String sessionId;

  const TableOrderPage({super.key, required this.tableId, required this.sessionId});

  @override
  State<TableOrderPage> createState() => _TableOrderPageState();
}

class _TableOrderPageState extends State<TableOrderPage> {
  final _orderService = OrderService();
  final List<CartLine> _cart = [];
  final _searchController = TextEditingController();

  String get _tableId => widget.tableId;
  String get _sessionId => widget.sessionId;

  String _searchQuery = '';
  String _selectedCategory = 'All';
  _SortMode _sortMode = _SortMode.defaultOrder;

  @override
  void initState() {
    super.initState();
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

  /// Shown bottom-left when the cart is empty — the customer's username if
  /// they're logged in, or "Browsing as guest" for anonymous sessions.
  String get _identityLabel {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || user.isAnonymous) return 'Browsing as guest';
    final name = user.displayName;
    final label = (name != null && name.isNotEmpty) ? name : (user.email ?? 'there');
    return 'Hi, $label';
  }

  Future<void> _submitOrder() async {
    final orderId = await _orderService.submitOrder(tableId: _tableId, sessionId: _sessionId, cart: _cart);
    if (!mounted) return;
    Navigator.of(context).pop();
    setState(() => _cart.clear());
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Order sent to the kitchen — ref $orderId')),
    );
  }

  void _openCart() {
    bool isSubmitting = false;
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => CartSheet(
          cart: _cart,
          isSubmitting: isSubmitting,
          onAdjust: (line, delta) {
            _adjustLine(line, delta);
            setSheetState(() {});
          },
          onSubmit: () async {
            if (isSubmitting) return; // already in flight — ignore extra taps
            setSheetState(() => isSubmitting = true);
            try {
              await _submitOrder(); // pops the sheet itself on success
            } catch (e) {
              setSheetState(() => isSubmitting = false); // let them retry
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Couldn\u2019t place the order — please try again.')),
                );
              }
            }
          },
        ),
      ),
    );
  }

  /// Skips the cart — submits a one-item order immediately, independent of
  /// whatever's already sitting in _cart (that cart is left untouched).
  Future<void> _buyNow(MenuItem item, int quantity, String note) async {
    final orderId = await _orderService.submitOrder(
      tableId: _tableId,
      sessionId: _sessionId,
      cart: [CartLine(item: item, quantity: quantity, note: note)],
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Order sent to the kitchen — ref $orderId')),
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
        onBuyNow: (qty, note) => _buyNow(item, qty, note),
      ),
    );
  }

  void _openPendingOrders() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PendingOrdersPage(tableId: _tableId, sessionId: _sessionId)),
    );
  }

  void _openProfile() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return StreamBuilder<bool>(
      stream: _orderService.watchOrderingPaused(_tableId, _sessionId),
      builder: (context, billSnap) {
        final billRequested = billSnap.data ?? false;

        return Scaffold(
          bottomNavigationBar: _BottomNav(
            onTapOrders: _openPendingOrders,
            onTapProfile: _openProfile,
          ),
          body: SafeArea(
            bottom: false,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 680),
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
                      _Header(tableId: _tableId),
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

                            switch (_sortMode) {
                              case _SortMode.bestSellers:
                                filtered.sort((a, b) => b.soldCount.compareTo(a.soldCount));
                                break;
                              case _SortMode.topRated:
                                filtered.sort((a, b) => b.avgRating.compareTo(a.avgRating));
                                break;
                              case _SortMode.defaultOrder:
                                break;
                            }

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
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: _CategoryDropdown(
                                          categories: categories,
                                          selected: _selectedCategory,
                                          onChanged: (cat) => setState(() => _selectedCategory = cat),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        flex: 2,
                                        child: _SortDropdown(
                                          selected: _sortMode,
                                          onChanged: (mode) => setState(() => _sortMode = mode),
                                        ),
                                      ),
                                    ],
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
                                      : LayoutBuilder(
                                    builder: (context, constraints) {
                                      final isNarrow = constraints.maxWidth < 420;
                                      return GridView.builder(
                                        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: isNarrow ? 2 : 3,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 10,
                                          childAspectRatio: isNarrow ? 0.58 : 0.70,
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
                        identityLabel: _identityLabel,
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

  const _Header({required this.tableId});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 380;
        final logoSize = isNarrow ? 40.0 : 52.0;

        final tableBadge = Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.gold,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'Table $tableId',
            style: text.bodySmall?.copyWith(color: AppColors.forest, fontWeight: FontWeight.w600),
          ),
        );

        final titleBlock = Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Plates & Pours',
                style: text.displaySmall?.copyWith(fontSize: isNarrow ? 16 : 19),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (!isNarrow) ...[
                const SizedBox(height: 2),
                Text('Garden Resto & Café', style: text.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ],
          ),
        );

        if (!isNarrow) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset('assets/logo.jpg', width: logoSize, height: logoSize, fit: BoxFit.cover),
                ),
                const SizedBox(width: 14),
                titleBlock,
                const SizedBox(width: 8),
                tableBadge,
              ],
            ),
          );
        }

        // Narrow layout: logo/title on one line, table badge drops to
        // its own line below instead of squeezing everything sideways.
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset('assets/logo.jpg', width: logoSize, height: logoSize, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 10),
                  titleBlock,
                ],
              ),
              const SizedBox(height: 10),
              tableBadge,
            ],
          ),
        );
      },
    );
  }
}

/// Replaces the old header icon-buttons. "Menu" is always the highlighted
/// tab since this page IS the menu; tapping "Your Orders" or "Profile"
/// pushes that page and returns here on back, same pattern as the admin
/// app's own bottom nav.
class _BottomNav extends StatelessWidget {
  final VoidCallback onTapOrders;
  final VoidCallback onTapProfile;

  const _BottomNav({required this.onTapOrders, required this.onTapProfile});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      onTap: (index) {
        if (index == 1) onTapOrders();
        if (index == 2) onTapProfile();
      },
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.forest,
      unselectedItemColor: AppColors.forestMuted,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: 'Menu'),
        BottomNavigationBarItem(icon: Icon(Icons.receipt_long_outlined), label: 'Your Orders'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
      ],
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

class _CategoryDropdown extends StatelessWidget {
  final List<String> categories;
  final String selected;
  final ValueChanged<String> onChanged;

  const _CategoryDropdown({
    required this.categories,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selected,
          isExpanded: true,
          menuMaxHeight: 280,
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.forestMuted),
          style: text.bodyMedium,
          dropdownColor: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          items: [
            for (final cat in categories)
              DropdownMenuItem(value: cat, child: Text(cat)),
          ],
          onChanged: (value) {
            if (value != null) onChanged(value);
          },
        ),
      ),
    );
  }
}

class _SortDropdown extends StatelessWidget {
  final _SortMode selected;
  final ValueChanged<_SortMode> onChanged;

  const _SortDropdown({required this.selected, required this.onChanged});

  String _label(_SortMode mode) {
    switch (mode) {
      case _SortMode.defaultOrder:
        return 'Sort: Default';
      case _SortMode.bestSellers:
        return 'Best sellers';
      case _SortMode.topRated:
        return 'Top rated';
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<_SortMode>(
          value: selected,
          isExpanded: true,
          menuMaxHeight: 280,
          icon: const Icon(Icons.swap_vert, color: AppColors.forestMuted, size: 18),
          style: text.bodyMedium?.copyWith(fontSize: 13),
          dropdownColor: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          items: [
            for (final mode in _SortMode.values)
              DropdownMenuItem(
                value: mode,
                child: Text(_label(mode), overflow: TextOverflow.ellipsis),
              ),
          ],
          onChanged: (value) {
            if (value != null) onChanged(value);
          },
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
        padding: const EdgeInsets.all(10),
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
            Text(item.category, style: text.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 3),
            StarRatingDisplay(average: item.avgRating, count: item.ratingCount),
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
                    width: 26,
                    height: 26,
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
  final String identityLabel;
  final VoidCallback? onViewCart;

  const _CartBar({
    required this.itemCount,
    required this.total,
    required this.identityLabel,
    required this.onViewCart,
  });

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
                ? identityLabel
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
