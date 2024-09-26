import 'package:flutter/material.dart';
import 'package:money_tracker/DATA/constants/app_constants.dart';
import '../../DATA/constants/app_borders.dart';
import 'app_colors.dart';
import 'text_styles.dart';

/// Builds the base theme data for both light and dark themes.
/// Customizes the look and feel of the app through colors, typography, and UI components.
abstract class ThisAppThemesBuilder {
  /// Builds ThemeData for the app by using custom color schemes, app bar styles, and UI components.
  static ThemeData buildThemeData({
    required bool isDark, // Specifies if the theme is dark mode.
    required ColorScheme colorScheme, // Custom color scheme for the theme.
    required Color scaffoldBackgroundColor, // Background color for scaffold.
    required Color appBarBackgroundColor, // App bar background color.
    required Color barBackgroundColor, // Bar background color
    required Color dividerColor, //  for dividers between UI elements.
    required Color highlightColor, //  for highlighted UI elements.
    required Color splashColor, // Splash effect color for buttons.
    required Color tooltipColor, // Tooltip color.
    required Color tabBarIndicatorColor, //  for the tab bar indicator.
    required Color tabBarLabelColor, //  for active tab bar labels.
    required Color tabBarUnselectedLabelColor, // for inactive tab bar labels.
  }) {
    return ThemeData(
      // General theme properties
      brightness: isDark ? Brightness.dark : Brightness.light,
      primarySwatch: AppColors.primarySwatch,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      textTheme: AppTextStyles.kTextThemeData(isDark, colorScheme),
      visualDensity: VisualDensity.adaptivePlatformDensity,

      // AppBar configuration
      appBarTheme: AppBarTheme(
        elevation: AppConstants.elevationCommon,
        centerTitle: false,
        iconTheme: IconThemeData(color: colorScheme.primary),
        titleTextStyle: AppTextStyles.kTextThemeData(isDark, colorScheme)
            .titleSmall
            ?.copyWith(color: colorScheme.onSurface.withOpacity(0.7)),
        toolbarTextStyle:
            AppTextStyles.kTextThemeData(isDark, colorScheme).bodyMedium,
        color: scaffoldBackgroundColor.withOpacity(0.2),
      ),

      // Card configuration
      cardTheme: CardTheme(
        color: isDark
            ? colorScheme.inverseSurface.withOpacity(0.15)
            : colorScheme.surface.withOpacity(0.5),
        shadowColor: colorScheme.shadow.withOpacity(0.6),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 3,
        shape: AppBordersStyling.appRoundedRectangleBorder(colorScheme),
      ),

      // DatePicker configuration
      datePickerTheme: DatePickerThemeData(
        backgroundColor: colorScheme.surface.withOpacity(isDark ? 0.25 : 0.6),
        shape: AppBordersStyling.appRoundedRectangleBorder(colorScheme),
        dayStyle: TextStyle(color: colorScheme.onSurface),
        todayBorder: BorderSide(color: colorScheme.primary),
        headerBackgroundColor: colorScheme.primary.withOpacity(0.6),
        headerForegroundColor: colorScheme.onPrimary,
      ),

      // Dialog configuration
      dialogTheme: DialogTheme(
        backgroundColor: colorScheme.surface.withOpacity(0.9),
        shape: AppBordersStyling.appRoundedRectangleBorder(colorScheme),
        elevation: AppConstants.elevationCommon,
        titleTextStyle:
            AppTextStyles.kTextThemeData(isDark, colorScheme).titleMedium,
        contentTextStyle:
            AppTextStyles.kTextThemeData(isDark, colorScheme).bodyMedium,
      ),

      // DropdownMenu configuration
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          fillColor: colorScheme.surface.withOpacity(isDark ? 0.15 : 0.25),
          filled: true,
          border: AppBordersStyling.appOutlineInputBorder(colorScheme).copyWith(
              borderSide: BorderSide(
                  color: colorScheme.onSurface.withOpacity(0.2), width: 1.5)),
        ),
        menuStyle: MenuStyle(
          backgroundColor: WidgetStateProperty.all(
            colorScheme.surface.withOpacity(isDark ? 0.5 : 0.7),
          ),
          shape: WidgetStateProperty.all(
              AppBordersStyling.appRoundedRectangleBorder(colorScheme)),
          shadowColor: WidgetStateProperty.all(
            colorScheme.shadow.withOpacity(0.1),
          ),
          elevation: WidgetStateProperty.all(5),
        ),
      ),

      // ElevatedButton configuration
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(WidgetState.pressed)) {
                return colorScheme.primary.withOpacity(0.6);
              } else if (states.contains(WidgetState.disabled)) {
                return colorScheme.primary.withOpacity(0.3);
              }
              return colorScheme.primary.withOpacity(isDark ? 0.45 : 0.7);
            },
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            AppBordersStyling.appRoundedRectangleBorder(colorScheme),
          ),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          ),
          textStyle: WidgetStateProperty.all(
            AppTextStyles.kTextThemeData(isDark, colorScheme).labelLarge,
          ),
          elevation: WidgetStateProperty.all(5),
        ),
      ),

      // InputDecoration configuration
      inputDecorationTheme: InputDecorationTheme(
        labelStyle:
            AppTextStyles.kTextThemeData(isDark, colorScheme).labelMedium,
        floatingLabelStyle: AppTextStyles.kTextThemeData(isDark, colorScheme)
            .labelLarge
            ?.copyWith(color: colorScheme.primary),
        hintStyle: AppTextStyles.kTextThemeData(isDark, colorScheme)
            .bodySmall
            ?.copyWith(
              color: colorScheme.onSurface.withOpacity(0.5),
              fontStyle: FontStyle.italic,
            ),
        errorStyle: AppTextStyles.kTextThemeData(isDark, colorScheme)
            .bodySmall
            ?.copyWith(
              color: colorScheme.error,
            ),
        border: AppBordersStyling.appOutlineInputBorder(colorScheme),
        filled: true,
        fillColor: colorScheme.surface.withOpacity(0.15),
        enabledBorder: AppBordersStyling.appOutlineInputBorder(colorScheme)
            .copyWith(
                borderSide:
                    BorderSide(color: colorScheme.primary.withOpacity(0.4))),
        focusedBorder: AppBordersStyling.appOutlineInputBorder(colorScheme),
        errorBorder: AppBordersStyling.appOutlineInputBorder(colorScheme)
            .copyWith(
                borderSide: BorderSide(color: colorScheme.error, width: 1)),
        focusedErrorBorder: AppBordersStyling.appOutlineInputBorder(colorScheme)
            .copyWith(
                borderSide: BorderSide(color: colorScheme.error, width: 1.5)),
      ),
    );
  }
}
