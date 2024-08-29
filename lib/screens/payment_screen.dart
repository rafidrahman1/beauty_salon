import 'package:flutter/material.dart';
import 'package:beauty_salon/services/stripe_service.dart'; // Import your StripeService

class PaymentScreen extends StatefulWidget {
  final double amount; // Amount to be charged
  final Future<void> Function() onSuccess; // Callback function to submit the form

  const PaymentScreen({
    required this.amount,
    required this.onSuccess,
    super.key,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool _isProcessing = false; // Track payment processing state

  Future<void> _makePayment() async {
    setState(() {
      _isProcessing = true;
    });

    try {
      final result = await StripeService.instance.makePayment(widget.amount);

      if (result) {
        // Payment successful
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Payment successful!'),
          ),
        );
        await widget.onSuccess(); // Call the callback function to submit the form
        Navigator.pop(context); // Go back to previous screen or main screen
      } else {
        // Payment failed
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Payment failed. Please try again.'),
          ),
        );
      }
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
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
