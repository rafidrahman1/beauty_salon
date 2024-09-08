import 'package:flutter/material.dart';

bool isValidTime(TimeOfDay selectedTime) {
  return selectedTime.hour >= 9 && selectedTime.hour < 17;
}

TimeOfDay calculateEndTime(TimeOfDay startTime, int duration) {
  final endTimeHour = (startTime.hour + (startTime.minute + duration) ~/ 60) % 24;
  final endTimeMinute = (startTime.minute + duration) % 60;
  return TimeOfDay(hour: endTimeHour, minute: endTimeMinute);
}
