/*
    In this app will be used Isar DB for local storage, RiverPod for theme changing, GetIt for DIs
 */
import 'dart:ui';

import 'package:flutter/material.dart';
import 'DATA/helpers/error.dart';
import 'DATA/providers/gen_data_provider.dart';
import 'UI/pages/main_screen.dart';
import 'DATA/themes_set/app_themes/app_themes.dart';
import 'DATA/themes_set/themes_provider.dart';
import 'DOMAIN/Services/_service_locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await initializeApp();

    // Отримуємо MediaQuery після ініціалізації
    final mediaQueryData =
        MediaQueryData.fromView(PlatformDispatcher.instance.views.first);

    runApp(
      ProviderScope(
        overrides: [
          generalDataProvider.overrideWith((ref) =>
              GeneralDataNotifier(mediaQueryData)), // Передаємо MediaQueryData
        ],
        child: const MoneyTrackerApp(),
      ),
    );
  } catch (e) {
    runApp(ErrorApp(errorMessage: e.toString())); // Логування помилок
  }
}

Future<void> initializeApp() async {
  await DIServiceLocator.instance.setupDependencies();
}

class MoneyTrackerApp extends ConsumerWidget {
  const MoneyTrackerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      darkTheme: ThisAppThemes.kDarkTheme,
      theme: ThisAppThemes.kLightTheme,
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
}
