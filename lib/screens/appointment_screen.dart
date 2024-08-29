import 'package:beauty_salon/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:beauty_salon/model/product.dart';
import 'package:beauty_salon/services/product_service.dart';
import 'package:beauty_salon/widget/appointment_time_picker.dart';
import 'package:beauty_salon/widget/appointment_date_picker.dart';
import 'package:beauty_salon/widget/appointment_utils.dart';
import 'package:intl/intl.dart';
import 'package:beauty_salon/global.dart' as globals;

class AppointmentScreen extends StatefulWidget {
  final int productId;
  final int productDuration; // Duration in minutes for the selected product

  const AppointmentScreen({
    required this.productId,
    required this.productDuration, // Pass this duration from the previous screen
    super.key,
  });

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = const TimeOfDay(hour: 9, minute: 0);
  late TimeOfDay _endTime; // This will hold the calculated end time

  Product? _product; // To store the product details

  @override
  void initState() {
    super.initState();
    _endTime = _calculateEndTime(_selectedTime, widget.productDuration);
    _fetchProduct(); // Fetch the product details
  }

  TimeOfDay _calculateEndTime(TimeOfDay startTime, int duration) {
    final endTimeHour = (startTime.hour + (startTime.minute + duration) ~/ 60) % 24;
    final endTimeMinute = (startTime.minute + duration) % 60;
    return TimeOfDay(hour: endTimeHour, minute: endTimeMinute);
  }

  void _onTimeSelected(TimeOfDay selectedTime) {
    if (isValidTime(selectedTime)) {
      setState(() {
        _selectedTime = selectedTime;
        _endTime = _calculateEndTime(selectedTime, widget.productDuration);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a time between 9 AM and 5 PM'),
        ),
      );
    }
  }

  Future<void> _fetchProduct() async {
    try {
      final product = await ProductService().fetchProductById(widget.productId);
      setState(() {
        _product = product;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching product: $e'),
        ),
      );
    }
  }

  void _confirmAppointment() {
    if (_product == null) return; // Ensure product is fetched

    final formattedDate = DateFormat('dd-MMM-yy').format(_selectedDate);
    final formattedStartTime = _selectedTime.format(context);
    final formattedEndTime = _endTime.format(context);

    // Add the product to the global selected products list
    globals.selectedProducts.add(_product!);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Appointment booked for $formattedDate from $formattedStartTime to $formattedEndTime'),
      ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(productId: widget.productId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book an Appointment'),
      ),
      body: Padding(
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
            Text('End Time: ${_endTime.format(context)}'), // Display the calculated end time
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _confirmAppointment,
              child: const Text('Confirm Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}
