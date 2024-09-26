import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../DATA/constants/app_strings.dart';
import '../../DOMAIN/providers/gen_data_provider.dart';
import '../../DOMAIN/providers/themes_provider.dart';
import '../components/text_widgets.dart';

/// The SettingsWidget allows users to modify app settings, such as theme switching
/// and toggling between charts. This widget adapts based on screen orientation (responsive layout).
class SettingsWidget extends ConsumerWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataProvider = ref.watch(appGeneralDataProvider);
    final theme = ref.watch(themeDataProvider);
    final isDarkMode = theme.brightness == Brightness.dark;
    final textTheme = theme.textTheme;

    // Responsive layout depending on screen orientation
    return LayoutBuilder(
      builder: (context, constraints) {
        final layoutWidgets = _buildSettingsList(
          context: context,
          ref: ref,
          theme: theme,
          isDarkMode: isDarkMode,
          dataProvider: dataProvider,
          textTheme: textTheme,
        );

        // Return either portrait or landscape layout
        return constraints.maxWidth < 600
            ? _buildLayoutWithPadding(layoutWidgets,
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0))
            : _buildLayoutWithPadding(
                layoutWidgets, const EdgeInsets.symmetric(horizontal: 80));
      },
    );
  }

  /// Builds a list of settings options (switch rows) such as Dark Theme and Chart type.
  List<Widget> _buildSettingsList({
    required BuildContext context,
    required WidgetRef ref,
    required ThemeData theme,
    required bool isDarkMode,
    required dynamic dataProvider,
    required TextTheme textTheme,
  }) {
    return [
      // Toggle for switching between dark and light theme
      _buildSwitchRow(
        context: context,
        text: AppStrings.darkTheme,
        value: isDarkMode,
        onChanged: (value) {
          ref.read(themeProvider.notifier).toggleTheme(value);
        },
        textTheme: textTheme,
        theme: theme,
      ),
      const SizedBox(height: 20),
      // Toggle for selecting between different types of charts
      _buildSwitchRow(
        context: context,
        text: AppStrings.isMainChart,
        value: dataProvider.isFirstChart,
        onChanged: (value) {
          ref.read(appGeneralDataProvider.notifier).toggleChart(value);
        },
        textTheme: textTheme,
        theme: theme,
      ),
    ];
  }

  /// Helper method to apply padding to the layout and wrap the content inside a column.
  Widget _buildLayoutWithPadding(List<Widget> children, EdgeInsets padding) {
    return Padding(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }

  /// Builds a switch row with a label and toggle button for settings.
  /// It dynamically updates the setting based on user interaction.
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
        // Displays the label for the setting (e.g., "Dark Theme")
        StyledText.bodyLarge(theme, text, color: colorScheme.onSurface),
        // Toggle switch for the setting
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
