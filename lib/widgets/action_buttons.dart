import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onAddMore;
  final VoidCallback onConfirmOrder;

  const ActionButtons({
    required this.onAddMore,
    required this.onConfirmOrder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onAddMore,
          child: const Text('Add More Products'),
        ),
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: onConfirmOrder,
          child: const Text('Confirm Order'),
        ),
      ],
    );
  }
}
