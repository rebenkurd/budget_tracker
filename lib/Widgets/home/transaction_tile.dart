import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final Map<String, dynamic> transaction;

  const TransactionTile({
    super.key,
    required this.transaction,
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
        subtitle: Text(
          transaction['date'].toDate().toString().split(' ')[0],
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        trailing: Text(
          '${transaction['type'] == 'revenue' ? '+' : '-'}\$${transaction['amount'].toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: transaction['type'] == 'revenue' ? Colors.green : Colors.red,
          ),
        ),
      ),
    );
  }
}
