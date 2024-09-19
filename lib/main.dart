/*
Copyright [2024] [Roman Godun]
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
   http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

/*
    In this app will be used Isar DB for local storage, RiverPod for theme changing, GetIt for DIs
 */

import 'package:flutter/material.dart';
import 'UI/components/cashed_on_get_it.dart';
import 'UI/pages/main_screen.dart';
import 'data/Theme_configuration/Themes_provider/app_themes.dart';
import 'data/Theme_configuration/Themes_provider/themes_provider.dart';
import 'domain/Services/_service_locator.dart';
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
          // Використовуємо кешований віджет для завантаження
          return DIServiceLocator.instance
              .get<AppCashedWidgets1>()
              .loadingWidget;
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
