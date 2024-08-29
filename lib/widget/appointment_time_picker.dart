import 'package:flutter/material.dart';

class AppointmentTimePicker extends StatelessWidget {
  final TimeOfDay selectedTime;
  final ValueChanged<TimeOfDay> onTimeSelected;

  const AppointmentTimePicker({
    super.key,
    required this.selectedTime,
    required this.onTimeSelected,
  });

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (pickedTime != null) {
      onTimeSelected(pickedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Select Time'),
      subtitle: Text(selectedTime.format(context)),
      trailing: const Icon(Icons.access_time),
      onTap: () => _selectTime(context),
    );
  }
}
