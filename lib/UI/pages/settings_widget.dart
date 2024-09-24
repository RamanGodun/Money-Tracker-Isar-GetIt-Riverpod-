import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/DATA/themes_set/themes_provider.dart';
import '../../DATA/providers/gen_data_provider.dart';
import '../../DATA/themes_set/app_themes/app_colors.dart';
import '../../DATA/helpers/helpers.dart';

class SettingsWidget extends ConsumerWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;
    final generalData = ref.watch(generalDataProvider);
    // final isFirstChart = ref.watch(chartTypeProvider);
    final isFirstChart = generalData.isFirstChart;
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
                ref.read(generalDataProvider.notifier).toggleChart(value);
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
