import 'package:flutter/material.dart';

import '../core/theme/app_text_styles.dart';

/// Generic "nothing here" placeholder, reused by any module with an empty
/// list state.
class AppEmptyState extends StatelessWidget {
  final IconData icon;
  final String message;

  const AppEmptyState({
    super.key,
    this.icon = Icons.inbox_outlined,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48, color: Colors.grey),
          const SizedBox(height: 8),
          Text(message, style: AppTextStyles.caption),
        ],
      ),
    );
  }
}
