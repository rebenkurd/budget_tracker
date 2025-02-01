import 'package:flutter/material.dart';
import 'transaction_tile.dart';

class TransactionList extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;
  final VoidCallback onSeeAllPressed;

  const TransactionList({
    super.key,
    required this.transactions,
    required this.onSeeAllPressed,
  });

  Map<String, List<Map<String, dynamic>>> _groupTransactionsByDay() {
    Map<String, List<Map<String, dynamic>>> groupedTransactions = {};

    for (var transaction in transactions) {
      final date = transaction['date'].toDate().toString().split(' ')[0];
      if (groupedTransactions.containsKey(date)) {
        groupedTransactions[date]!.add(transaction);
      } else {
        groupedTransactions[date] = [transaction];
      }
    }

    return groupedTransactions;
  }

  @override
  Widget build(BuildContext context) {
    final groupedTransactions = _groupTransactionsByDay();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Transactions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: onSeeAllPressed,
              child: const Text('See All',
                  style: TextStyle(color: Colors.blueAccent)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...groupedTransactions.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  entry.key,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              ...entry.value.map((transaction) => TransactionTile(
                    transaction: transaction,
                  )),
            ],
          );
        }),
      ],
    );
  }
}