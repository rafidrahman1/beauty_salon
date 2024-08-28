import 'package:flutter/material.dart';
import 'package:beauty_salon/widget/appointmen_time_picker.dart';
import 'package:beauty_salon/widget/appointment_date_picker.dart';
import 'package:beauty_salon/widget/appointment_utils.dart';
import 'package:beauty_salon/screens/user_screen.dart';
import 'package:intl/intl.dart';

class AppointmentScreen extends StatefulWidget {
  final int productId;
  const AppointmentScreen({required this.productId, super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = const TimeOfDay(hour: 9, minute: 0);

  void _confirmAppointment() {
    final formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
    final formattedTime = _selectedTime.format(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Appointment booked for $formattedDate at $formattedTime'),
      ),
    );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UserScreen()),
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
              onTimeSelected: (time) {
                if (isValidTime(time)) {
                  setState(() {
                    _selectedTime = time;
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select a time between 9 AM and 5 PM'),
                    ),
                  );
                }
              },
            ),
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
