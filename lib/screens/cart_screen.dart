// lib/screens/cart_screen.dart
import 'package:flutter/material.dart';
import 'package:beauty_salon/services/cart_service.dart';
import 'package:beauty_salon/screens/product_screen.dart'; // Adjust import as necessary

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartItems = CartService().cartItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          TextButton(
            onPressed: () {
              CartService().clearCart();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductScreen(categoryId: 1), // Adjust categoryId as necessary
                ),
              );
            },
            child: const Text('Add More', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Text('Price: \$${item.price} | Quantity: ${item.quantity}'),
            trailing: Text('\$${item.price * item.quantity}'),
          );
        },
      ),
    );
  }
}
