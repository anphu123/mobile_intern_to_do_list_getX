import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/loading/loading_service.dart';

/// Wrap a page's body with this to dim it while [LoadingService] is active,
/// e.g. `AppLoadingOverlay(child: ListView(...))`.
class AppLoadingOverlay extends StatelessWidget {
  final Widget child;

  const AppLoadingOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final loading = Get.find<LoadingService>();
    return Stack(
      children: [
        child,
        Obx(
          () => loading.isLoading.value
              ? Container(
                  color: Colors.black.withValues(alpha: 0.1),
                  child: const Center(child: CircularProgressIndicator()),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
