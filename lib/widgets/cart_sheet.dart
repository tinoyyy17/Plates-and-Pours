import 'package:flutter/material.dart';
import '../models/menu_item.dart';
import '../theme/app_theme.dart';

/// Modal sheet where a customer reviews their cart, adjusts quantities,
/// and confirms the order — the "Select Items & Finalize Cart" step.
class CartSheet extends StatelessWidget {
  final List<CartLine> cart;
  final bool isSubmitting;
  final void Function(CartLine line, int delta) onAdjust;
  final VoidCallback onSubmit;

  const CartSheet({
    super.key,
    required this.cart,
    required this.isSubmitting,
    required this.onAdjust,
    required this.onSubmit,
  });

  double get _total => cart.fold(0, (sum, l) => sum + l.subtotal);

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your order', style: text.displaySmall?.copyWith(fontSize: 22)),
            const SizedBox(height: 16),
            if (cart.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  'Nothing added yet — tap an item on the menu to start.',
                  style: text.bodyMedium?.copyWith(color: AppColors.forestMuted),
                ),
              )
            else
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: cart.length,
                  separatorBuilder: (_, __) =>
                      Divider(height: 24, color: AppColors.border),
                  itemBuilder: (context, i) {
                    final line = cart[i];
                    return Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(line.item.name, style: text.bodyLarge),
                              const SizedBox(height: 2),
                              Text(
                                '₱${line.item.price.toStringAsFixed(2)}',
                                style: text.bodySmall,
                              ),
                              if (line.note.isNotEmpty) ...[
                                const SizedBox(height: 2),
                                Text(
                                  line.note,
                                  style: text.bodySmall?.copyWith(fontStyle: FontStyle.italic),
                                ),
                              ],
                            ],
                          ),
                        ),
                        _QtyStepper(
                          quantity: line.quantity,
                          onDecrement: () => onAdjust(line, -1),
                          onIncrement: () => onAdjust(line, 1),
                        ),
                      ],
                    );
                  },
                ),
              ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total', style: text.bodyLarge),
                Text(
                  '₱${_total.toStringAsFixed(2)}',
                  style: text.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (cart.isEmpty || isSubmitting) ? null : onSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.gold,
                  disabledBackgroundColor: AppColors.border,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: isSubmitting
                    ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.forest),
                )
                    : Text('Place order', style: text.labelLarge),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QtyStepper extends StatelessWidget {
  final int quantity;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const _QtyStepper({
    required this.quantity,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _StepperButton(icon: Icons.remove, onTap: onDecrement),
        SizedBox(
          width: 28,
          child: Text(
            '$quantity',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        _StepperButton(icon: Icons.add, onTap: onIncrement),
      ],
    );
  }
}

class _StepperButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _StepperButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 30,
        height: 30,
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
