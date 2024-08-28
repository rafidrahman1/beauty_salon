import 'package:flutter/material.dart';
import '../services/order_service.dart';
import '../utils/form_validators.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _orderNameController = TextEditingController();
  final _orderEmailController = TextEditingController();
  final _orderPhoneController = TextEditingController();
  final _orderCommentController = TextEditingController();

  @override
  void dispose() {
    _orderNameController.dispose();
    _orderEmailController.dispose();
    _orderPhoneController.dispose();
    _orderCommentController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final orderName = _orderNameController.text;
      final orderEmail = _orderEmailController.text;
      final orderPhone = _orderPhoneController.text;
      final orderComment = _orderCommentController.text;
      final orderDetails = "Some details"; // Add as necessary
      final orderPrice = 100.00; // Add as necessary

      final result = await OrderService.createOrder(
        name: orderName,
        email: orderEmail,
        phone: orderPhone,
        comment: orderComment,
        details: orderDetails,
        price: orderPrice,
      );

      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Order Created Successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create order')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _orderNameController,
                decoration: const InputDecoration(labelText: 'Order Name'),
                validator: (value) => FormValidators.validateRequired(value, 'Order name is required'),
              ),
              const SizedBox(height: 16.0),

              TextFormField(
                controller: _orderEmailController,
                decoration: const InputDecoration(labelText: 'Order Email'),
                keyboardType: TextInputType.emailAddress,
                validator: FormValidators.validateEmail,
              ),
              const SizedBox(height: 16.0),

              TextFormField(
                controller: _orderPhoneController,
                decoration: const InputDecoration(labelText: 'Order Phone Number'),
                keyboardType: TextInputType.phone,
                validator: FormValidators.validatePhoneNumber,
              ),
              const SizedBox(height: 16.0),

              TextFormField(
                controller: _orderCommentController,
                decoration: const InputDecoration(labelText: 'Order Comment'),
                maxLines: 3,
              ),
              const SizedBox(height: 32.0),

              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
