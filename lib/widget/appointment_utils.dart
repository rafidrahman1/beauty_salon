import 'package:flutter/material.dart';

bool isValidTime(TimeOfDay time) {
  return time.hour >= 9 && time.hour <= 17;
}
