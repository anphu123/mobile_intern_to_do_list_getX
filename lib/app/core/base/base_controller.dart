import 'package:get/get.dart';

import '../errors/error_handler.dart';

/// Base class for feature controllers.
///
/// Wraps an action with a busy flag and routes any thrown error through
/// [ErrorHandler], so individual controllers don't repeat try/catch +
/// isLoading bookkeeping.
abstract class BaseController extends GetxController {
  final isBusy = false.obs;
  final errorMessage = RxnString();

  Future<void> runSafely(Future<void> Function() action) async {
    try {
      isBusy.value = true;
      errorMessage.value = null;
      await action();
    } catch (e) {
      errorMessage.value = e.toString();
      ErrorHandler.handle(e);
    } finally {
      isBusy.value = false;
    }
  }
}
