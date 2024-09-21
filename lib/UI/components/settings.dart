import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/data/Theme_configuration/Themes_provider/themes_provider.dart';
import '../../data/Theme_configuration/app_colors/app_colors.dart';
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
      color: theme.colorScheme.surface.withOpacity(0.2),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSwitchRow(
              context: context,
              text: 'Темна тема',
              value: isDarkMode,
              onChanged: (value) {
                ref.read(themeProvider.notifier).toggleTheme(value);
              },
              textTheme: textTheme,
              theme: theme,
            ),
            const SizedBox(height: 20),
            _buildSwitchRow(
              context: context,
              text: 'Основний чарт',
              value: isFirstChart,
              onChanged: (value) {
                ref.read(chartTypeProvider.notifier).toggleChartType(value);
              },
              textTheme: textTheme,
              theme: theme,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchRow({
    required BuildContext context,
    required String text,
    required bool value,
    required Function(bool) onChanged,
    required TextTheme textTheme,
    required ThemeData theme,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.8),
          ),
        ),
        Switch.adaptive(
          value: value,
          onChanged: onChanged,
          activeColor: theme.colorScheme.primary,
          inactiveTrackColor: AppColors.cupertinoBlackColor.withOpacity(0.2),
        ),
      ],
    );
  }
}
