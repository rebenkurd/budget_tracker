import 'package:flutter/material.dart';
import 'transaction_tile.dart';

class TransactionGroup extends StatelessWidget {
  final String date;
  final List<Map<String, dynamic>> transactions;
  final Function() onRefresh;

  const TransactionGroup({
    super.key,
    required this.date,
    required this.transactions,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            date,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
        ),
        ...transactions.map((transaction) => TransactionTile(
              transaction: transaction,
              onRefresh: onRefresh,
            )),
      ],
    );
  }
}
