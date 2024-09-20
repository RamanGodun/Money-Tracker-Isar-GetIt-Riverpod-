import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/data/Theme_configuration/Themes_provider/themes_provider.dart';
import '../../data/helpers/helpers.dart';
import '../../data/providers/chart_type_provider.dart';

class SettingsWidget extends ConsumerWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;
    final isFirstChart = ref.watch(chartTypeProvider);
    ThemeData theme = Helpers.themeGet(context);
    TextTheme textTheme = Helpers.textThemeGet(context);

    return Material(
      color: theme.colorScheme.surface.withOpacity(0.1),
      child: Column(
        children: [
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Темна тема',
                  style: textTheme.titleSmall
                      ?.copyWith(color: theme.colorScheme.onSurface)),
              Switch.adaptive(
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
              Text('Основний чарт',
                  style: textTheme.titleSmall
                      ?.copyWith(color: theme.colorScheme.onSurface)),
              Switch.adaptive(
                value: isFirstChart,
                onChanged: (value) {
                  // Зміна типу чарту через провайдер
                  ref.read(chartTypeProvider.notifier).toggleChartType(value);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
