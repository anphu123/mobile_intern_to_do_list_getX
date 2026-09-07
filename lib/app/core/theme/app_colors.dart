import 'package:flutter/material.dart';

/// Centralized color palette so widgets never hardcode a [Color] directly.
abstract class AppColors {
  AppColors._();

  static const seed = Colors.teal;

  static const success = Color(0xFF2E7D32);
  static const danger = Color(0xFFC62828);
  static const muted = Color(0xFF9E9E9E);
}
