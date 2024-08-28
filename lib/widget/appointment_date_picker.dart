import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const AppointmentDatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      onDateSelected(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Select Date'),
      subtitle: Text(DateFormat('yyyy-MM-dd').format(selectedDate)),
      trailing: const Icon(Icons.calendar_today),
      onTap: () => _selectDate(context),
    );
  }
}
