// import 'package:flutter/material.dart';

// /// `CashedDataService` is a utility class that caches certain UI-related data
// /// (such as theme, color scheme, and device size) to avoid redundant computations
// /// and enhance performance. Cached values can be reset manually if necessary.
// class CashedDataService {
//   ThemeData? _cashedTheme;
//   ColorScheme? _cashedColorScheme;
//   TextTheme? _cashedTextTheme;
//   bool? _isDarkMode;
//   Size? _cashedDeviceSize;

//   /// Returns the cached theme or fetches it from the context if not cached.
//   /// This method caches the theme data to avoid calling `Theme.of(context)` multiple times.
//   ThemeData getTheme(BuildContext context) {
//     _cashedTheme ??= Theme.of(context);
//     return _cashedTheme!;
//   }

//   /// Returns the cached color scheme or fetches it from the context if not cached.
//   /// Similar to `getTheme()`, this method caches the color scheme to avoid redundant lookups.
//   ColorScheme getColorScheme(BuildContext context) {
//     _cashedColorScheme ??= Theme.of(context).colorScheme;
//     return _cashedColorScheme!;
//   }

//   /// Returns the cached text theme or fetches it from the context if not cached.
//   /// This method caches the text theme to improve performance when frequently accessing text styles.
//   TextTheme getTextTheme(BuildContext context) {
//     _cashedTextTheme ??= Theme.of(context).textTheme;
//     return _cashedTextTheme!;
//   }

//   /// Determines if the current theme is dark mode and caches the result.
//   /// This method prevents repeated checks of the theme's brightness.
//   bool getIsDarkMode(BuildContext context) {
//     _isDarkMode ??= Theme.of(context).brightness == Brightness.dark;
//     return _isDarkMode!;
//   }

//   /// Returns the cached device size or fetches it from the context if not cached.
//   /// This caches the device's size using `MediaQuery.of(context).size`, preventing
//   /// repeated calls to the `MediaQuery` widget.
//   Size getDeviceSize(BuildContext context) {
//     _cashedDeviceSize ??= MediaQuery.of(context).size;
//     return _cashedDeviceSize!;
//   }

//   /// Returns the height of the device screen by fetching the cached size or calculating it.
//   double getDeviceHeight(BuildContext context) {
//     return getDeviceSize(context).height;
//   }

//   /// Returns the width of the device screen by fetching the cached size or calculating it.
//   double getDeviceWidth(BuildContext context) {
//     return getDeviceSize(context).width;
//   }

//   /// Resets the cached theme, color scheme, text theme, and dark mode state.
//   /// This is useful when the theme changes or when clearing cached data.
//   void resetThemeCache() {
//     _cashedTheme = null;
//     _cashedColorScheme = null;
//     _cashedTextTheme = null;
//     _isDarkMode = null;
//   }

//   /// Resets the cached device size.
//   /// This method is useful when the device orientation changes or when refreshing UI layout.
//   void resetDeviceSizeCache() {
//     _cashedDeviceSize = null;
//   }
// }
