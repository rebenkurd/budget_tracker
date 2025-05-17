import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionDateField extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateChanged;

  const TransactionDateField({
    super.key,
    required this.selectedDate,
    required this.onDateChanged,
  });

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      onDateChanged(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            selectedDate == null
                ? 'No date chosen'
                : 'Date: ${DateFormat('yyyy-MM-dd').format(selectedDate!)}',
            style: const TextStyle(fontSize: 16),
          ),
        ),
        TextButton(
          onPressed: () => _selectDate(context),
          child: const Text(
            'Choose Date',
            style: TextStyle(color: Colors.blueAccent, fontSize: 16),
          ),
        ),
      ],
    );
  }
}