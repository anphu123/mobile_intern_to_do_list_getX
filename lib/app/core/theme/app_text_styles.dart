import 'package:flutter/material.dart';

/// Reusable text styles shared across modules.
abstract class AppTextStyles {
  AppTextStyles._();

  static const title = TextStyle(fontSize: 20, fontWeight: FontWeight.w600);

  static const body = TextStyle(fontSize: 15);

  static const done = TextStyle(
    fontSize: 15,
    decoration: TextDecoration.lineThrough,
    color: Colors.grey,
  );

  static const caption = TextStyle(fontSize: 12, color: Colors.grey);
}
