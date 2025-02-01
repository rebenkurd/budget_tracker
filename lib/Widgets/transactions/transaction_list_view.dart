import 'package:budget_tracker/utils/transaction_utils.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'transaction_group.dart';

class TransactionListView extends StatelessWidget {
  final String selectedMonth;
  final DateTime? selectedDay;
  final Function() onRefresh;

  const TransactionListView({
    super.key,
    required this.selectedMonth,
    required this.selectedDay,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('expenses').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No transactions found.'));
        }

        final transactions = snapshot.data!.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return {...data, 'id': doc.id};
        }).toList();

        final filteredTransactions = TransactionUtils.filterTransactions(
          transactions,
          selectedMonth,
          selectedDay,
        );

        final groupedTransactions =
            TransactionUtils.groupTransactionsByDay(filteredTransactions);

        return ListView(
          padding: const EdgeInsets.all(16),
          children: groupedTransactions.entries.map((entry) {
            return TransactionGroup(
              date: entry.key,
              transactions: entry.value,
              onRefresh: onRefresh,
            );
          }).toList(),
        );
      },
    );
  }
}