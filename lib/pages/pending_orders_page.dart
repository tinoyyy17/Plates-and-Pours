import 'package:flutter/material.dart';
import '../services/order_service.dart';
import '../theme/app_theme.dart';

class PendingOrdersPage extends StatelessWidget {
  final String tableId;
  final _orderService = OrderService();

  PendingOrdersPage({super.key, required this.tableId});

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
      ),
      body: StreamBuilder<bool>(
        stream: _orderService.watchBillRequested(tableId),
        builder: (context, billSnap) {
          final billRequested = billSnap.data ?? false;

          return StreamBuilder<List<Map<String, dynamic>>>(
            stream: _orderService.watchTableOrders(tableId),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'Couldn\u2019t load your orders:\n${snapshot.error}',
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
                        ElevatedButton(
                          onPressed: billRequested
                              ? null
                              : () async {
                            await _orderService.requestBill(tableId);
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