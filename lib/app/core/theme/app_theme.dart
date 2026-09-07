import 'package:flutter/material.dart';

import 'app_colors.dart';

/// App-wide [ThemeData] definitions. Add new theme tokens here instead of
/// inline in widgets so light/dark mode stay consistent.
abstract class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.seed),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.seed,
          brightness: Brightness.dark,
        ),
      );
}
