import 'package:flutter/material.dart';
import 'package:beauty_salon/services/stripe_service.dart';
import 'package:beauty_salon/services/order_service.dart'; // Import OrderService
import 'package:beauty_salon/global.dart' as globals;

class PaymentScreen extends StatefulWidget {
  final double amount;
  final String orderName;
  final String orderEmail;
  final String orderPhone;
  final String orderComment;

  const PaymentScreen({
    required this.amount,
    required this.orderName,
    required this.orderEmail,
    required this.orderPhone,
    required this.orderComment,
    super.key,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool _isProcessing = false;
  double? _calculatedPrice;

  Future<void> _makePayment() async {
    setState(() {
      _isProcessing = true;
    });

    try {
      final paymentResult = await StripeService.instance.makePayment(widget.amount);

      if (paymentResult) {
        final orderDetails = globals.selectedProducts.map((product) {
          return '${product.name} - Time: ${product.time} min | Price: \$${product.price}';
        }).join('\n');

        final orderCreatedPrice = await OrderService.createOrder(
          name: widget.orderName,
          email: widget.orderEmail,
          phone: widget.orderPhone,
          comment: widget.orderComment,
          details: orderDetails,
          price: widget.amount,
          productIds: globals.globalProductIds,
        );

        if (orderCreatedPrice != null) {
          setState(() {
            _calculatedPrice = orderCreatedPrice;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Order Created Successfully')),
          );
          Navigator.pop(context); // Go back to previous screen or main screen
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to create order')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Payment failed. Please try again.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Amount to be charged: \$${widget.amount.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (_calculatedPrice != null)
              Text(
                'Calculated Price: \$${_calculatedPrice!.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            const SizedBox(height: 20),
            if (_isProcessing)
              const CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: _makePayment,
                child: const Text('Pay Now'),
              ),
          ],
        ),
      ),
    );
  }
}
