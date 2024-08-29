import 'package:flutter/material.dart';

class OrderForm extends StatefulWidget {
  final Future<void> Function(String, String, String, String) onSubmitOrder;

  const OrderForm({required this.onSubmitOrder, super.key});

  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
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

  Future<void> _submitOrder() async {
    if (_formKey.currentState!.validate()) {
      final orderName = _orderNameController.text;
      final orderEmail = _orderEmailController.text;
      final orderPhone = _orderPhoneController.text;
      final orderComment = _orderCommentController.text;

      await widget.onSubmitOrder(orderName, orderEmail, orderPhone, orderComment);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _orderNameController,
              decoration: const InputDecoration(labelText: 'Order Name'),
              validator: (value) => value == null || value.isEmpty ? 'Order name is required' : null,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _orderEmailController,
              decoration: const InputDecoration(labelText: 'Order Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) => value == null || value.isEmpty || !RegExp(r"^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$").hasMatch(value) ? 'Enter a valid email' : null,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _orderPhoneController,
              decoration: const InputDecoration(labelText: 'Order Phone Number'),
              keyboardType: TextInputType.phone,
              validator: (value) => value == null || value.isEmpty || !RegExp(r"^\d{10}$").hasMatch(value) ? 'Enter a valid phone number' : null,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _orderCommentController,
              decoration: const InputDecoration(labelText: 'Order Comment'),
              maxLines: 3,
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _submitOrder,
              child: const Text('Submit Order'),
            ),
          ],
        ),
      ),
    );
  }
}
