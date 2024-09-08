import 'package:flutter/material.dart';
import 'package:beauty_salon/screens/payment_screen.dart';
import 'package:beauty_salon/widgets/order_form.dart';
import 'package:beauty_salon/global.dart' as globals;

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  Future<void> _onSubmitOrder(
      String orderName,
      String orderEmail,
      String orderPhone,
      String orderComment,
      ) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen(
          amount: globals.selectedProducts.fold(
            0.0,
                (sum, product) => sum + product.price,
          ),
          orderName: orderName,
          orderEmail: orderEmail,
          orderPhone: orderPhone,
          orderComment: orderComment,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Information'),
      ),
      body: OrderForm(
        onSubmitOrder: _onSubmitOrder,
      ),
    );
  }
}
