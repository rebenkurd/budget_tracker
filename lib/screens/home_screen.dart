// home_screen.dart
import 'package:budget_tracker/Widgets/home/month_dropdown.dart';
import 'package:budget_tracker/Widgets/home/net_revenue_display.dart';
import 'package:budget_tracker/Widgets/home/summary_card.dart';
import 'package:budget_tracker/Widgets/home/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'transactions_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _transactions = [];
  double _totalRevenue = 0.0;
  double _totalExpense = 0.0;
  bool _isLoading = true;
  String _selectedMonth = DateFormat('yyyy-MM').format(DateTime.now());

  Future<void> _fetchTransactions() async {
    try {
      final snapshot = await _firestore.collection('expenses').get();
      double revenue = 0.0;
      double expense = 0.0;
      List<Map<String, dynamic>> transactions = [];

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final date = data['date'].toDate();
        final month = DateFormat('yyyy-MM').format(date);

        if (month == _selectedMonth) {
          transactions.add({...data, 'id': doc.id});
          if (data['type'] == 'revenue') {
            revenue += data['amount'];
          } else {
            expense += data['amount'];
          }
        }
      }

      setState(() {
        _transactions = transactions;
        _totalRevenue = revenue;
        _totalExpense = expense;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching transactions: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final netRevenue = _totalRevenue - _totalExpense;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        actions: [
          MonthDropdown(
            selectedMonth: _selectedMonth,
            onChanged: (String? newValue) {
              setState(() {
                _selectedMonth = newValue!;
                _fetchTransactions();
              });
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.blueAccent))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NetRevenueDisplay(netRevenue: netRevenue),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: SummaryCard(
                          title: 'Revenue',
                          amount: _totalRevenue,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SummaryCard(
                          title: 'Expense',
                          amount: _totalExpense,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  TransactionList(
                    transactions: _transactions,
                    onSeeAllPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TransactionsScreen(
                            onRefresh: _fetchTransactions,
                            
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}