import 'package:budget_tracker/Widgets/add_transaction/transaction_amount_field.dart';
import 'package:budget_tracker/Widgets/add_transaction/transaction_date_picker.dart';
import 'package:budget_tracker/Widgets/add_transaction/transaction_submit_button.dart';
import 'package:budget_tracker/Widgets/add_transaction/transaction_title_field.dart';
import 'package:budget_tracker/Widgets/add_transaction/transaction_type_dropdown.dart';
import 'package:budget_tracker/services/transactions_firestore.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final Map<String, dynamic>? transaction;
  final Function() onRefresh;

  const TransactionForm({
    Key? key,
    this.transaction,
    required this.onRefresh,
  }) : super(key: key);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  String _transactionType = 'revenue';
  final _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _initializeFormData();
  }

  void _initializeFormData() {
    if (widget.transaction != null) {
      _titleController.text = widget.transaction!['title'] ?? '';
      _amountController.text = widget.transaction!['amount']?.toString() ?? '';
      _selectedDate = widget.transaction!['date']?.toDate();
      _transactionType = widget.transaction!['type'] ?? 'revenue';
    } else {
      _selectedDate = DateTime.now();
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      final transactionData = {
        'title': _titleController.text,
        'amount': double.parse(_amountController.text),
        'date': _selectedDate!,
        'type': _transactionType,
      };

      try {
        if (widget.transaction != null) {
          await _firestoreService.updateTransaction(
            widget.transaction!['id'],
            transactionData,
          );
          _showMessage(context, 'Transaction updated successfully');
        } else {
          await _firestoreService.addTransaction(transactionData);
          _showMessage(context, 'Transaction saved successfully');
        }

        widget.onRefresh();
        Navigator.pop(context, true);
        
      } catch (e) {
        _showMessage(context, 'Failed to save transaction: $e');
      }
    } else {
      _showMessage(context, 'Please fill all required fields');
    }
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 16),
          TransactionTitleField(controller: _titleController),
          const SizedBox(height: 16),
          TransactionAmountField(controller: _amountController),
          const SizedBox(height: 16),
          TransactionTypeField(
            value: _transactionType,
            onChanged: (value) {
              setState(() => _transactionType = value!);
            },
          ),
          const SizedBox(height: 16),
          TransactionDateField(
            selectedDate: _selectedDate,
            onDateChanged: (date) {
              setState(() => _selectedDate = date);
            },
          ),
          const SizedBox(height: 24),
          SubmitButton(
            isEdit: widget.transaction != null,
            onPressed: _submitForm,
          ),
        ],
      ),
    );
  }
}
