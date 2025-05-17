import 'package:budget_tracker/Widgets/add_transaction/transaction_form.dart';
import 'package:flutter/material.dart';

class AddTransactionScreen extends StatelessWidget {
  final Map<String, dynamic>? transaction;
  final Function() onRefresh;

  const AddTransactionScreen({
    super.key,
    this.transaction,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          transaction != null ? 'Edit Transaction' : 'Add Transaction',
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TransactionForm(
          transaction: transaction,
          onRefresh: onRefresh,
        ),
      ),
    );
  }
}
