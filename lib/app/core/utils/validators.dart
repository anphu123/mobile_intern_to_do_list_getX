import 'package:get/get.dart';

import '../errors/app_exception.dart';

/// Input validators shared across controllers/forms.
abstract class Validators {
  Validators._();

  /// Throws [AppException] when [title] is blank; returns the trimmed
  /// title otherwise.
  static String todoTitle(String title) {
    final trimmed = title.trim();
    if (trimmed.isEmpty) {
      throw AppException('error_empty_title'.tr);
    }
    return trimmed;
  }
}
