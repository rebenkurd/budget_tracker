import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final bool isEdit;
  final VoidCallback onPressed;

  const SubmitButton({
    super.key,
    required this.isEdit,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      ),
      child: Text(
        isEdit ? 'Update Transaction' : 'Add Transaction',
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}