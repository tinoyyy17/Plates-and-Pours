import 'package:flutter/material.dart';
import '../models/menu_item.dart';
import '../services/feedback_service.dart';
import '../theme/app_theme.dart';

class ItemDetailSheet extends StatefulWidget {
  final MenuItem item;
  final void Function(int quantity, String note) onAddToCart;

  /// Skips the cart entirely — submits an order for just this item right
  /// away. Optional so existing callers that don't pass it just don't get
  /// the button.
  final Future<void> Function(int quantity, String note)? onBuyNow;

  const ItemDetailSheet({
    super.key,
    required this.item,
    required this.onAddToCart,
    this.onBuyNow,
  });

  @override
  State<ItemDetailSheet> createState() => _ItemDetailSheetState();
}

class _ItemDetailSheetState extends State<ItemDetailSheet> {
  int _quantity = 1;
  final _noteController = TextEditingController();
  bool _buyingNow = false;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final item = widget.item;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.imageUrl != null && item.imageUrl!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: AspectRatio(
                  aspectRatio: 1.6,
                  child: Image.network(
                    item.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.border.withOpacity(0.4),
                      alignment: Alignment.center,
                      child: const Icon(Icons.broken_image, color: AppColors.forestMuted),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Text(item.name, style: text.displaySmall?.copyWith(fontSize: 22)),
            const SizedBox(height: 4),
            Text('₱${item.price.toStringAsFixed(2)}', style: text.bodyLarge),
            if (item.description != null && item.description!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(item.description!, style: text.bodyMedium),
            ],
            if (item.ingredients.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text('Ingredients', style: text.titleMedium),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final ing in item.ingredients)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.cardBg,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text(ing, style: text.bodySmall),
                    ),
                ],
              ),
            ],
            const SizedBox(height: 20),
            StreamBuilder<List<Map<String, dynamic>>>(
              stream: FeedbackService().watchItemComments(item.id),
              builder: (context, snap) {
                final comments = snap.data ?? [];
                if (comments.isEmpty) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Recent comments', style: text.titleMedium?.copyWith(fontSize: 14)),
                      const SizedBox(height: 8),
                      for (final c in comments)
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.cardBg,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '"${(c['comment'] ?? '').toString()}"',
                            style: text.bodySmall,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
            Text('Notes (allergies, special requests)', style: text.titleMedium?.copyWith(fontSize: 14)),
            const SizedBox(height: 8),
            TextField(
              controller: _noteController,
              maxLines: 2,
              style: text.bodyMedium,
              decoration: InputDecoration(
                hintText: 'e.g. no peanuts, less sugar',
                hintStyle: TextStyle(color: AppColors.forestMuted),
                filled: true,
                fillColor: AppColors.cardBg,
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
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _RoundButton(
                  icon: Icons.remove,
                  onTap: () => setState(() => _quantity = (_quantity - 1).clamp(1, 99)),
                ),
                SizedBox(
                  width: 40,
                  child: Text('$_quantity', textAlign: TextAlign.center, style: text.bodyLarge),
                ),
                _RoundButton(
                  icon: Icons.add,
                  onTap: () => setState(() => _quantity = (_quantity + 1).clamp(1, 99)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _buyingNow
                        ? null
                        : () {
                      widget.onAddToCart(_quantity, _noteController.text.trim());
                      Navigator.of(context).pop();
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.forest,
                      side: const BorderSide(color: AppColors.border),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text('Add to cart', style: text.labelLarge?.copyWith(color: AppColors.forest)),
                  ),
                ),
                if (widget.onBuyNow != null) ...[
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _buyingNow
                          ? null
                          : () async {
                        setState(() => _buyingNow = true);
                        try {
                          await widget.onBuyNow!(_quantity, _noteController.text.trim());
                          if (context.mounted) Navigator.of(context).pop();
                        } catch (e) {
                          if (mounted) {
                            setState(() => _buyingNow = false);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Couldn’t place the order — please try again.')),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.gold,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 0,
                      ),
                      child: _buyingNow
                          ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.forest),
                      )
                          : Text('Buy now', style: text.labelLarge),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _RoundButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 34,
        height: 34,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.border),
        ),
        child: Icon(icon, size: 16, color: AppColors.forest),
      ),
    );
  }
}
