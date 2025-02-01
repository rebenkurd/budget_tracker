import 'package:budget_tracker/Widgets/transactions/transaction_list_view.dart';
import 'package:budget_tracker/Widgets/transactions/transactions_header.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'add_transaction_screen.dart';

class TransactionsScreen extends StatefulWidget {
  final Function() onRefresh;

  const TransactionsScreen({super.key, required this.onRefresh});

  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String _selectedMonth = DateFormat('yyyy-MM').format(DateTime.now());
  DateTime? _selectedDay;

  void _onMonthChanged(String? newValue) {
    setState(() {
      _selectedMonth = newValue!;
      _selectedDay = null;
    });
  }

  Future<void> _selectDay(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDay = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Transactions',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        actions: [
          TransactionsHeader(
            selectedMonth: _selectedMonth,
            onMonthChanged: _onMonthChanged,
            onDaySelect: () => _selectDay(context),
          ),
        ],
      ),
      body: TransactionListView(
        selectedMonth: _selectedMonth,
        selectedDay: _selectedDay,
        onRefresh: widget.onRefresh,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTransactionScreen(
                onRefresh: widget.onRefresh,
              ),
            ),
          );
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}