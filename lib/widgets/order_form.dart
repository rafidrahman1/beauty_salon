import 'package:flutter/material.dart';
import 'package:beauty_salon/utils/form_validators.dart';
import 'package:beauty_salon/global.dart' as globals;

class OrderForm extends StatefulWidget {
  final Future<void> Function(
      String orderName,
      String orderEmail,
      String orderPhone,
      String orderComment,
      ) onSubmitOrder;

  const OrderForm({required this.onSubmitOrder, super.key});

  @override
  State<OrderForm> createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  final _formKey = GlobalKey<FormState>();
  final _orderNameController = TextEditingController();
  final _orderEmailController = TextEditingController();
  final _orderPhoneController = TextEditingController();
  final _orderCommentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _orderNameController.text = globals.globalOrderName;
    _orderEmailController.text = globals.globalOrderEmail;
    _orderPhoneController.text = globals.globalOrderPhone;
    _orderCommentController.text = globals.globalOrderComment;
  }

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
      await widget.onSubmitOrder(
        _orderNameController.text,
        _orderEmailController.text,
        _orderPhoneController.text,
        _orderCommentController.text,
      );
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
              validator: (value) => FormValidators.validateRequired(
                value,
                'Order name is required',
              ),
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
              onPressed: _submitOrder,
              child: const Text('Submit Order'),
            ),
          ],
        ),
      ),
    );
  }
}
