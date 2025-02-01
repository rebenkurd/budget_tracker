import 'package:flutter/material.dart';

class NetRevenueDisplay extends StatelessWidget {
  final double netRevenue;

  const NetRevenueDisplay({
    super.key,
    required this.netRevenue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Net Revenue',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Text(
          '\$${netRevenue.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
