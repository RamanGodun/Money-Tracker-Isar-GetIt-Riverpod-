/*
    Author: [Roman Godun]
    © [2024] All rights reserved.
    
    Expenses Tracker Application: 
    This application is designed to help users track their daily expenses, categorize them, and display useful insights using a variety of UI components.

    The app leverages:
    - Isar DB for efficient local storage and database management.
    - RiverPod for state management and dependency injection across the app.
    - GetIt for service location and managing global services such as database services and preferences.
    - Flutter Hooks for managing animations and memoization in the widget lifecycle.
    - SharedPreferences for persisting user preferences such as theme mode across app restarts.
    - Material and Cupertino design elements for a modern and responsive UI experience.

    This application follows a clean architecture approach, separating data handling, business logic, and UI layers.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'DATA/data_services/sh_prefs_service.dart';
import 'DATA/helpers/error_widget.dart';
import 'DOMAIN/providers/gen_data_provider.dart';
import 'UI/pages/main_screen.dart';
import 'UI/themes_configuration/app_themes.dart';
import 'DOMAIN/providers/themes_provider.dart';
import 'DOMAIN/Services/_service_locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///  This function is an entry app point, initializes required services
///  and sets up the application with a `ProviderScope` for state management
void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures Flutter is fully initialized before running the app
  try {
    await initializeApp(); // Initializes services like GetIt, Isar, SharedPreferences, etc.

    final mediaQueryData =
        MediaQueryData.fromView(PlatformDispatcher.instance.views.first);

    runApp(
      ProviderScope(
        // Sets up the RiverPod state management scope
        overrides: [
          appGeneralDataProvider.overrideWith((ref) => GeneralDataNotifier(
                mediaQuery: mediaQueryData,
                sharedPreferencesService:
                    AppServiceLocator.instance.get<SharedPreferencesService>(),
              )),
        ],
        child: const ExpensesTrackerApp(),
      ),
    );
  } catch (e) {
    runApp(ErrorScreen(
        errorDescription:
            e.toString())); // Displays an error screen if initialization fails
  }
}

/// Initializes all the necessary GetIt services at app startup.
Future<void> initializeApp() async {
  await AppServiceLocator.instance.initialize();
}

class ExpensesTrackerApp extends ConsumerWidget {
  const ExpensesTrackerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watches the current theme (light or dark mode) using RiverPod's themeProvider
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      darkTheme: AppThemes.darkTheme,
      theme: AppThemes.lightTheme,
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
}
