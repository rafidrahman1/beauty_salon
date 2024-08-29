import 'package:flutter/material.dart';
import 'package:beauty_salon/screens/payment_screen.dart';
import 'package:beauty_salon/services/order_service.dart';
import 'package:beauty_salon/global.dart' as globals;
import 'package:beauty_salon/widgets/order_form.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Information'),
      ),
      body: OrderForm(
        onSubmitOrder: (orderName, orderEmail, orderPhone, orderComment) async {
          globals.globalOrderName = orderName;
          globals.globalOrderEmail = orderEmail;
          globals.globalOrderPhone = orderPhone;
          globals.globalOrderComment = orderComment;

          final productDetails = globals.selectedProducts.map((product) {
            return '${product.name} - Time: ${product.time} min | Price: \$${product.price}';
          }).join('\n');

          final totalAmount = globals.selectedProducts.fold(
            0.0,
                (sum, product) => sum + product.price,
          );

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentScreen(
                amount: totalAmount,
                onSuccess: () async {
                  final result = await OrderService.createOrder(
                    name: orderName,
                    email: orderEmail,
                    phone: orderPhone,
                    comment: orderComment,
                    details: productDetails,
                    price: totalAmount,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(result
                          ? 'Order Created Successfully'
                          : 'Failed to create order'),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
