import 'package:flutter/material.dart';

class TransactionTypeField extends StatelessWidget {
  final String value;
  final ValueChanged<String?> onChanged;

  const TransactionTypeField({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: const InputDecoration(
        labelText: 'Type',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.swap_vert),
      ),
      items: ['revenue', 'expense'].map((type) {
        return DropdownMenuItem(
          value: type,
          child: Text(type[0].toUpperCase() + type.substring(1)),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a type';
        }
        return null;
      },
    );
  }
}