import '../utils/app_snackbar.dart';
import 'app_exception.dart';

/// Single place that turns a caught error into user feedback.
///
/// Controllers should not call [AppSnackbar] directly for errors — route
/// them through here so the presentation (snackbar vs dialog vs log) can be
/// changed in one spot later.
abstract class ErrorHandler {
  ErrorHandler._();

  static void handle(Object error) {
    final message = error is AppException ? error.message : error.toString();
    AppSnackbar.error(message);
  }
}
