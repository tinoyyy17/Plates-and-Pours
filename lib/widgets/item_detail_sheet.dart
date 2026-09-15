import 'package:flutter/material.dart';
import '../models/menu_item.dart';
import '../theme/app_theme.dart';

class ItemDetailSheet extends StatefulWidget {
  final MenuItem item;
  final void Function(int quantity, String note) onAddToCart;

  const ItemDetailSheet({
    super.key,
    required this.item,
    required this.onAddToCart,
  });

  @override
  State<ItemDetailSheet> createState() => _ItemDetailSheetState();
}

class _ItemDetailSheetState extends State<ItemDetailSheet> {
  int _quantity = 1;
  final _noteController = TextEditingController();

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
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    widget.onAddToCart(_quantity, _noteController.text.trim());
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.gold,
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 0,
                  ),
                  child: Text('Add to cart', style: text.labelLarge),
                ),
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
