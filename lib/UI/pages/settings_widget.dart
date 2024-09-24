import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../DATA/providers/gen_data_provider.dart';
import '../../DATA/themes_set/themes_provider.dart';
import '../components/text_widgets.dart';

class SettingsWidget extends ConsumerWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataProvider = ref.watch(generalDataProvider);
    final theme = ref.watch(themeDataProvider);
    final isDarkMode = theme.brightness == Brightness.dark;
    final textTheme = theme.textTheme;

    return Padding(
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
            value: dataProvider.isFirstChart,
            onChanged: (value) {
              ref.read(generalDataProvider.notifier).toggleChart(value);
            },
            textTheme: textTheme,
            theme: theme,
          ),
        ],
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
    final colorScheme = theme.colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StyledText.bodyLarge(theme, text, color: colorScheme.secondary),
        Switch.adaptive(
          value: value,
          onChanged: onChanged,
          activeColor: theme.colorScheme.primary,
          inactiveTrackColor: colorScheme.shadow.withOpacity(0.3),
        ),
      ],
    );
  }
}
