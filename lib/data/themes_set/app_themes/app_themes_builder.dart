import 'package:flutter/material.dart';
import 'package:money_tracker/DATA/constants/app_constants.dart';
import '../../constants/app_borders.dart';
import 'app_colors.dart';
import 'text_styles.dart';

abstract class ThisAppThemesBuilder {
  static ThemeData buildThemeData({
    required bool isDark,
    required ColorScheme colorScheme,
    required Color scaffoldBackgroundColor,
    required Color appBarBackgroundColor,
    required Color barBackgroundColor,
    required Color dividerColor,
    required Color highlightColor,
    required Color splashColor,
    required Color tooltipColor,
    required Color tabBarIndicatorColor,
    required Color tabBarLabelColor,
    required Color tabBarUnselectedLabelColor,
  }) {
    return ThemeData(
/*
GENERAL
 */
      brightness: isDark ? Brightness.dark : Brightness.light,
      primarySwatch: AppColors.kPrimarySwatch,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      textTheme: TextStyles4ThisAppThemes.kTextThemeData(isDark, colorScheme),
      visualDensity: VisualDensity.adaptivePlatformDensity,

/*
APPBAR
 */
      appBarTheme: AppBarTheme(
        elevation: AppConstants.elevationCommon,
        centerTitle: false,
        iconTheme: IconThemeData(color: colorScheme.primary),
        titleTextStyle:
            TextStyles4ThisAppThemes.kTextThemeData(isDark, colorScheme)
                .titleSmall,
        toolbarTextStyle:
            TextStyles4ThisAppThemes.kTextThemeData(isDark, colorScheme)
                .bodyMedium,
        color: scaffoldBackgroundColor.withOpacity(0.2),
      ),

/*
CardTheme
 */
      cardTheme: CardTheme(
        color: isDark
            ? colorScheme.inverseSurface.withOpacity(0.2)
            : colorScheme.surface.withOpacity(0.5),
        shadowColor: colorScheme.shadow.withOpacity(0.6),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 3,
        shape: AppBordersStyling.appRoundedRectangleBorder(colorScheme),
      ),

/*
DatePicker
 */
      datePickerTheme: DatePickerThemeData(
        backgroundColor: colorScheme.surface.withOpacity(isDark ? 0.25 : 0.6),
        shape: AppBordersStyling.appRoundedRectangleBorder(colorScheme),
        dayStyle: TextStyle(color: colorScheme.onSurface),
        todayBorder: BorderSide(color: colorScheme.primary),
        headerBackgroundColor: colorScheme.primary.withOpacity(0.6),
        headerForegroundColor: colorScheme.onPrimary,
      ),

/*
DialogTheme
 */
      dialogTheme: DialogTheme(
        backgroundColor: colorScheme.surface.withOpacity(0.9),
        shape: AppBordersStyling.appRoundedRectangleBorder(colorScheme),
        elevation: AppConstants.elevationCommon,
        titleTextStyle:
            TextStyles4ThisAppThemes.kTextThemeData(isDark, colorScheme)
                .titleMedium,
        contentTextStyle:
            TextStyles4ThisAppThemes.kTextThemeData(isDark, colorScheme)
                .bodyMedium,
      ),

/*
DropdownMenu
 */
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

/*
ELEVATED BUTTON 
 */
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
            TextStyles4ThisAppThemes.kTextThemeData(isDark, colorScheme)
                .labelLarge,
          ),
          elevation: WidgetStateProperty.all(5),
        ),
      ),

/*
INPUT DECORATION
 */
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyles4ThisAppThemes.kTextThemeData(isDark, colorScheme)
            .labelMedium,
        floatingLabelStyle:
            TextStyles4ThisAppThemes.kTextThemeData(isDark, colorScheme)
                .labelLarge
                ?.copyWith(color: colorScheme.primary),
        hintStyle: TextStyles4ThisAppThemes.kTextThemeData(isDark, colorScheme)
            .bodySmall
            ?.copyWith(
              color: colorScheme.onSurface.withOpacity(0.5),
              fontStyle: FontStyle.italic,
            ),
        errorStyle: TextStyles4ThisAppThemes.kTextThemeData(isDark, colorScheme)
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

/*
 */
    );
  }
}
