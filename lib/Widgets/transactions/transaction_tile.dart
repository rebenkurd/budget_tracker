import 'package:budget_tracker/screens/add_transaction_screen.dart';
import 'package:budget_tracker/utils/transaction_utils.dart';
import 'package:flutter/material.dart';


class TransactionTile extends StatelessWidget {
  final Map<String, dynamic> transaction;
  final Function() onRefresh;

  const TransactionTile({
    super.key,
    required this.transaction,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(
          transaction['type'] == 'revenue'
              ? Icons.arrow_upward
              : Icons.arrow_downward,
          color: transaction['type'] == 'revenue' ? Colors.green : Colors.red,
        ),
        title: Text(
          transaction['title'],
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              transaction['date'] != null
                  ? transaction['date'].toDate().toString().split(' ')[0]
                  : 'No date',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              'Amount: \$${transaction['amount'].toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 14,
                color: transaction['type'] == 'revenue'
                    ? Colors.green
                    : Colors.red,
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTransactionScreen(
                      onRefresh: onRefresh,
                      transaction: transaction,

                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                TransactionUtils.deleteTransaction(
                  transaction['id'],
                  context,
                  onRefresh,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}