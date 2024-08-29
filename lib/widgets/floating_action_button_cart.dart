import 'package:flutter/material.dart';

class FloatingActionButtonCart extends StatelessWidget {
  final VoidCallback onPressed;

  const FloatingActionButtonCart({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: const Icon(Icons.shopping_cart),
    );
  }
}
