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

import 'package:flutter/material.dart';
import 'UI/pages/0.home_screen.dart';
import 'data/Theme_configuration/Themes_provider/app_themes.dart';
import 'data/Theme_configuration/Themes_provider/themes_provider.dart';
import 'domain/Services/_service_locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
    In this app will be used Isar DB for local storage, RiverPod for theme changing, GetIt for DIs
 */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DIServiceLocator.instance.setupDependencies();

  runApp(const ProviderScope(child: MoneyTrackerApp()));
}

class MoneyTrackerApp extends ConsumerWidget {
  const MoneyTrackerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    return MaterialApp(
      darkTheme: ThisAppThemes.kDarkAndroidTheme,
      theme: ThisAppThemes.kLightAndroidTheme,
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      home: const ExpensesMainScreen(),
    );
  }
}
