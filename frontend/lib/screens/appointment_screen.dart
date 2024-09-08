import 'package:flutter/material.dart';
import 'package:beauty_salon/model/product.dart';
import 'package:beauty_salon/screens/product_detail_screen.dart';
import 'package:beauty_salon/services/product_service.dart';
import 'package:beauty_salon/widgets/appointment_date_picker.dart';
import 'package:beauty_salon/widgets/appointment_time_picker.dart';
import 'package:beauty_salon/widgets/appointment_end_time_display.dart';
import 'package:beauty_salon/utils/appointment_utils.dart';
import 'package:intl/intl.dart';
import 'package:beauty_salon/global.dart' as globals;

class AppointmentScreen extends StatefulWidget {
  final int productId;
  final int productDuration;

  const AppointmentScreen({
    required this.productId,
    required this.productDuration,
    super.key,
  });

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = const TimeOfDay(hour: 9, minute: 0);
  late TimeOfDay _endTime;
  late Future<Product> _productFuture;

  @override
  void initState() {
    super.initState();
    _endTime = calculateEndTime(_selectedTime, widget.productDuration);
    _productFuture = ProductService().fetchProductById(widget.productId);
  }

  void _onTimeSelected(TimeOfDay selectedTime) {
    if (isValidTime(selectedTime)) {
      setState(() {
        _selectedTime = selectedTime;
        _endTime = calculateEndTime(selectedTime, widget.productDuration);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a time between 9 AM and 5 PM'),
        ),
      );
    }
  }

  void _confirmAppointment(Product product) {
    final formattedDate = DateFormat('dd-MMM-yy').format(_selectedDate);
    final formattedStartTime = _selectedTime.format(context);
    final formattedEndTime = _endTime.format(context);

    globals.selectedProducts.add(product);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Appointment booked for $formattedDate from $formattedStartTime to $formattedEndTime'),
      ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book an Appointment'),
      ),
      body: FutureBuilder<Product>(
        future: _productFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Product not found'));
          } else {
            final product = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppointmentDatePicker(
                    selectedDate: _selectedDate,
                    onDateSelected: (date) {
                      setState(() {
                        _selectedDate = date;
                      });
                    },
                  ),
                  const SizedBox(height: 16.0),
                  AppointmentTimePicker(
                    selectedTime: _selectedTime,
                    onTimeSelected: _onTimeSelected,
                  ),
                  const SizedBox(height: 16.0),
                  AppointmentEndTimeDisplay(endTime: _endTime),
                  const SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: () => _confirmAppointment(product),
                    child: const Text('Confirm Appointment'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
