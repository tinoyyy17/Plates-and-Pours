import 'package:flutter/material.dart';
import '../services/feedback_service.dart';
import '../theme/app_theme.dart';
import '../widgets/star_rating.dart';

class RateVisitPage extends StatefulWidget {
  final String tableId;
  final String sessionId;
  final List<Map<String, String>> items; // distinct {id, name} ordered this visit

  const RateVisitPage({
    super.key,
    required this.tableId,
    required this.sessionId,
    required this.items,
  });

  @override
  State<RateVisitPage> createState() => _RateVisitPageState();
}

class _RateVisitPageState extends State<RateVisitPage> {
  int _serviceRating = 0;
  final _commentController = TextEditingController();
  final Map<String, int> _itemStars = {};
  bool _submitting = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_serviceRating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please rate the service before submitting.')),
      );
      return;
    }

    setState(() => _submitting = true);
    try {
      await FeedbackService().submitFeedback(
        tableId: widget.tableId,
        sessionId: widget.sessionId,
        serviceRating: _serviceRating,
        comment: _commentController.text.trim(),
        itemRatings: [
          for (final item in widget.items)
            if ((_itemStars[item['id']] ?? 0) > 0)
              {
                'item_id': item['id'],
                'item_name': item['name'],
                'stars': _itemStars[item['id']],
              },
        ],
      );
      if (!mounted) return;
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Thanks for your feedback!')),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Couldn’t submit — please try again.')),
        );
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.pageBg,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.forest,
        elevation: 0,
        title: Text('Rate your visit', style: text.titleMedium),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Overall service', style: text.titleMedium?.copyWith(fontSize: 15)),
          const SizedBox(height: 8),
          StarRatingInput(
            value: _serviceRating,
            onChanged: (v) => setState(() => _serviceRating = v),
            size: 34,
          ),
          const SizedBox(height: 20),
          Text('Comments (optional)', style: text.titleMedium?.copyWith(fontSize: 15)),
          const SizedBox(height: 8),
          TextField(
            controller: _commentController,
            maxLines: 3,
            style: text.bodyMedium,
            decoration: InputDecoration(
              hintText: 'Tell us how it went — anything we could do better?',
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
          if (widget.items.isNotEmpty) ...[
            const SizedBox(height: 24),
            Text('Rate what you had (optional)', style: text.titleMedium?.copyWith(fontSize: 15)),
            const SizedBox(height: 4),
            Text(
              'Only rated dishes count toward each item’s star average.',
              style: text.bodySmall,
            ),
            const SizedBox(height: 12),
            for (final item in widget.items)
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item['name'] ?? '',
                        style: text.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    StarRatingInput(
                      value: _itemStars[item['id']] ?? 0,
                      onChanged: (v) => setState(() => _itemStars[item['id']!] = v),
                      size: 20,
                    ),
                  ],
                ),
              ),
          ],
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitting ? null : _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.gold,
              disabledBackgroundColor: AppColors.border,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 0,
            ),
            child: _submitting
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.forest),
                  )
                : Text('Submit feedback', style: text.labelLarge),
          ),
        ],
      ),
    );
  }
}
