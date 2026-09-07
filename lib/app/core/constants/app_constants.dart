/// App-wide constants that don't belong to any single module.
abstract class AppConstants {
  AppConstants._();

  static const appName = 'To-Do List GetX';
}

/// Filter options for the to-do list.
enum TodoFilter { all, active, completed }
