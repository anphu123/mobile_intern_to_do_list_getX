import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/constants/app_constants.dart';
import 'core/loading/loading_service.dart';
import 'core/localization/app_translation.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_pages.dart';

/// Root widget. Registers app-wide services and wires up GetX (routing,
/// theming, localization).
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoadingService(), permanent: true);

    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      translations: AppTranslation(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
