import 'package:flutter/material.dart';

class AppointmentEndTimeDisplay extends StatelessWidget {
  final TimeOfDay endTime;

  const AppointmentEndTimeDisplay({required this.endTime, super.key});

  @override
  Widget build(BuildContext context) {
    return Text('End Time: ${endTime.format(context)}');
  }
}
