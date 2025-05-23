import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthDropdown extends StatelessWidget {
  final String selectedMonth;
  final ValueChanged<String?> onChanged;

  const MonthDropdown({
    super.key,
    required this.selectedMonth,
    required this.onChanged,
  });

  List<DropdownMenuItem<String>> _getMonthDropdownItems() {
    final now = DateTime.now();
    final months = List.generate(12, (index) {
      final date = DateTime(now.year, now.month - index);
      return DateFormat('yyyy-MM').format(date);
    });

    return months.map((month) {
      return DropdownMenuItem<String>(
        value: month,
        child: Text(month),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: 120,
        child: DropdownButton<String>(
          value: selectedMonth,
          onChanged: onChanged,
          items: _getMonthDropdownItems(),
          dropdownColor: Colors.blueAccent[100],
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          underline: Container(
            height: 2,
            color: Colors.white,
          ),
          iconSize: 30,
          elevation: 16,
          isExpanded: true,
          hint: const Text(
            'Select Month',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}