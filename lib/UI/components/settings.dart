import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/data/Theme_configuration/Themes_provider/themes_provider.dart';
import '../../data/providers/chart_type_provider.dart';

class SettingsWidget extends ConsumerWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;
    final isFirstChart = ref.watch(chartTypeProvider);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Темна тема'),
            CupertinoSwitch(
              value: isDarkMode,
              onChanged: (value) {
                // Зміна теми через провайдер
                ref.read(themeProvider.notifier).toggleTheme(value);
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Чарт 1/Чарт 2'),
            CupertinoSwitch(
              value: isFirstChart,
              onChanged: (value) {
                // Зміна типу чарту через провайдер
                ref.read(chartTypeProvider.notifier).toggleChartType(value);
              },
            ),
          ],
        ),
      ],
    );
  }
}
