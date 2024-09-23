/*
    In this app will be used Isar DB for local storage, RiverPod for theme changing, GetIt for DIs
 */

import 'package:flutter/material.dart';
import 'package:money_tracker/DATA/helpers/helpers.dart';
import 'UI/pages/main_screen.dart';
import 'DATA/Theme_configuration/Themes_provider/app_themes.dart';
import 'DATA/Theme_configuration/Themes_provider/themes_provider.dart';
import 'DOMAIN/Services/_service_locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  await initializeApp();
  runApp(const ProviderScope(child: MoneyTrackerApp()));
}

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DIServiceLocator.instance.setupDependencies();
}

class MoneyTrackerApp extends ConsumerWidget {
  const MoneyTrackerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.read(themeProvider.notifier).loadThemeFromPreferences(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator.adaptive(
              backgroundColor: Helpers.themeGet(context).colorScheme.onSurface);
        }

        final themeMode = ref.watch(themeProvider);

        return MaterialApp(
          darkTheme: ThisAppThemes.kDarkTheme,
          theme: ThisAppThemes.kLightTheme,
          themeMode: themeMode,
          debugShowCheckedModeBanner: false,
          home: const MainScreen(),
        );
      },
    );
  }
}
