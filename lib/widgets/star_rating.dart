import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Tappable 1–5 star row for submitting a rating.
class StarRatingInput extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;
  final double size;

  const StarRatingInput({
    super.key,
    required this.value,
    required this.onChanged,
    this.size = 28,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 1; i <= 5; i++)
          InkWell(
            onTap: () => onChanged(i),
            borderRadius: BorderRadius.circular(size),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Icon(
                i <= value ? Icons.star : Icons.star_border,
                color: AppColors.gold,
                size: size,
              ),
            ),
          ),
      ],
    );
  }
}

/// Read-only "★ 4.5 (12)" style summary for a menu card. Shows nothing
/// meaningful when [count] is 0 — caller decides whether to hide it
/// entirely or show a muted "No ratings yet" in that case.
class StarRatingDisplay extends StatelessWidget {
  final double average;
  final int count;
  final double size;

  const StarRatingDisplay({
    super.key,
    required this.average,
    required this.count,
    this.size = 14,
  });

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    if (count == 0) {
      return Text(
        'No ratings',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: text.bodySmall?.copyWith(color: AppColors.forestMuted, fontSize: 11),
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, color: AppColors.gold, size: size),
        const SizedBox(width: 3),
        Flexible(
          child: Text(
            '${average.toStringAsFixed(1)} ($count)',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: text.bodySmall?.copyWith(fontSize: 11, color: AppColors.forestMuted),
          ),
        ),
      ],
    );
  }
}
