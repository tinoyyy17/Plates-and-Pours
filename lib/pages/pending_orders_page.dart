import 'package:flutter/material.dart';
import '../services/feedback_service.dart';
import '../services/order_service.dart';
import '../theme/app_theme.dart';
import 'rate_visit_page.dart';

class PendingOrdersPage extends StatelessWidget {
  final String tableId;
  final String sessionId;
  final _orderService = OrderService();

  PendingOrdersPage({super.key, required this.tableId, required this.sessionId});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.pageBg,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.forest,
        elevation: 0,
        title: Text('Table $tableId · Your orders', style: text.titleMedium),
        actions: [
          _AssistanceButton(tableId: tableId, sessionId: sessionId),
          const SizedBox(width: 4),
        ],
      ),
      body: StreamBuilder<bool>(
        stream: _orderService.watchOrderingPaused(tableId, sessionId),
        builder: (context, billSnap) {
          final billRequested = billSnap.data ?? false;

          return StreamBuilder<List<Map<String, dynamic>>>(
            stream: _orderService.watchTableOrders(tableId, sessionId),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'Couldn’t load your orders:\n${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: text.bodySmall?.copyWith(color: AppColors.forestMuted),
                    ),
                  ),
                );
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final orders = snapshot.data!;
              if (orders.isEmpty) {
                return Center(
                  child: Text(
                    'No orders placed yet for this table.',
                    style: text.bodyMedium?.copyWith(color: AppColors.forestMuted),
                  ),
                );
              }

              final grandTotal = orders.fold<double>(
                0,
                    (sum, o) => sum + ((o['total'] ?? 0) as num).toDouble(),
              );
              final anyPaid = orders.any((o) => o['status'] == 'paid');
              final allPaid = orders.every((o) => o['status'] == 'paid');
              final allServedOrPaid =
              orders.every((o) => o['status'] == 'served' || o['status'] == 'paid');

              // Distinct dishes across every round this visit, for the
              // optional per-dish stars on the feedback form.
              final distinctItems = <String, String>{}; // item_id -> name
              for (final order in orders) {
                for (final item in List<Map<String, dynamic>>.from(order['items'] ?? [])) {
                  final id = item['item_id'] as String?;
                  if (id == null) continue;
                  distinctItems[id] = (item['name'] ?? '').toString();
                }
              }

              return Column(
                children: [
                  if (billRequested)
                    Container(
                      width: double.infinity,
                      color: AppColors.gold.withOpacity(0.25),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Text(
                        'Bill requested — a staff member is on the way to settle your tab.',
                        style: text.bodyMedium,
                      ),
                    ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: orders.length,
                      itemBuilder: (context, i) {
                        final order = orders[i];
                        final items = List<Map<String, dynamic>>.from(order['items'] ?? []);
                        final status = order['status'] ?? 'pending';

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Round ${orders.length - i}', style: text.titleMedium),
                                  _StatusPill(status: status),
                                ],
                              ),
                              const SizedBox(height: 8),
                              for (final item in items)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Text(
                                    '${item['quantity']}× ${item['name']}'
                                        '${(item['note'] ?? '').toString().isNotEmpty ? '  (${item['note']})' : ''}',
                                    style: text.bodyMedium,
                                  ),
                                ),
                              const SizedBox(height: 6),
                              Text(
                                '₱${((order['total'] ?? 0) as num).toStringAsFixed(2)}',
                                style: text.bodyLarge,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border(top: BorderSide(color: AppColors.border)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tab total', style: text.bodyLarge),
                            Text('₱${grandTotal.toStringAsFixed(2)}', style: text.titleMedium),
                          ],
                        ),
                        const SizedBox(height: 12),
                        if (allPaid)
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.gold,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              elevation: 0,
                            ),
                            child: Text('Order more', style: text.labelLarge),
                          )
                        else ...[
                          ElevatedButton(
                            onPressed: (billRequested || !allServedOrPaid)
                                ? null
                                : () async {
                              await _orderService.requestBill(tableId, sessionId);
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Bill requested — staff has been notified.'),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.gold,
                              disabledBackgroundColor: AppColors.border,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              elevation: 0,
                            ),
                            child: Text(
                              billRequested ? 'Bill already requested' : 'Request bill',
                              style: text.labelLarge,
                            ),
                          ),
                          if (!billRequested && !allServedOrPaid)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                'You can request the bill once every round has been served.',
                                textAlign: TextAlign.center,
                                style: text.bodySmall?.copyWith(color: AppColors.forestMuted),
                              ),
                            ),
                        ],
                        if (anyPaid)
                          StreamBuilder<bool>(
                            stream: FeedbackService().watchFeedbackSubmitted(tableId, sessionId),
                            builder: (context, feedbackSnap) {
                              final alreadySubmitted = feedbackSnap.data ?? false;
                              if (alreadySubmitted) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    'Thanks for rating your visit!',
                                    textAlign: TextAlign.center,
                                    style: text.bodySmall?.copyWith(color: AppColors.forestMuted),
                                  ),
                                );
                              }
                              return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: OutlinedButton(
                                  onPressed: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => RateVisitPage(
                                        tableId: tableId,
                                        sessionId: sessionId,
                                        items: [
                                          for (final entry in distinctItems.entries)
                                            {'id': entry.key, 'name': entry.value},
                                        ],
                                      ),
                                    ),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: AppColors.forest,
                                    side: const BorderSide(color: AppColors.border),
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  ),
                                  child: Text('Rate your visit', style: text.labelLarge?.copyWith(color: AppColors.forest)),
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

/// No time-based cooldown: tapping while a request is already open (this
/// session's assistance_requests doc still has status == 'requested') is a
/// no-op, so spamming can never produce more than one live notification on
/// the staff side. The moment staff resolves it, tapping again opens a
/// fresh one immediately.
class _AssistanceButton extends StatelessWidget {
  final String tableId;
  final String sessionId;

  const _AssistanceButton({required this.tableId, required this.sessionId});

  Future<void> _tap(BuildContext context, bool alreadyRequested) async {
    if (alreadyRequested) return;
    await OrderService().requestAssistance(tableId, sessionId);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('A staff member has been notified.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: OrderService().watchAssistanceRequested(tableId, sessionId),
      builder: (context, snap) {
        final requested = snap.data ?? false;
        return IconButton(
          onPressed: () => _tap(context, requested),
          tooltip: requested ? 'Assistance already requested' : 'Ask for assistance',
          icon: Icon(
            requested ? Icons.support_agent : Icons.support_agent_outlined,
            color: requested ? AppColors.forestMuted : AppColors.forest,
          ),
        );
      },
    );
  }
}

class _StatusPill extends StatelessWidget {
  final String status;
  const _StatusPill({required this.status});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.forest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: text.bodySmall?.copyWith(color: Colors.white, fontSize: 11),
      ),
    );
  }
}
