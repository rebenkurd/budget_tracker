import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TransactionUtils {
  static List<Map<String, dynamic>> filterTransactions(
    List<Map<String, dynamic>> transactions,
    String selectedMonth,
    DateTime? selectedDay,
  ) {
    return transactions.where((transaction) {
      final date = transaction['date'].toDate();
      final month = DateFormat('yyyy-MM').format(date);
      final day = DateFormat('yyyy-MM-dd').format(date);

      if (selectedDay != null) {
        return day == DateFormat('yyyy-MM-dd').format(selectedDay);
      } else {
        return month == selectedMonth;
      }
    }).toList();
  }

  static Map<String, List<Map<String, dynamic>>> groupTransactionsByDay(
    List<Map<String, dynamic>> transactions,
  ) {
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

  static Future<void> deleteTransaction(
    String id,
    BuildContext context,
    Function() onRefresh,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('expenses').doc(id).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Transaction deleted successfully')),
      );
      onRefresh();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete transaction: $e')),
      );
    }
  }
}