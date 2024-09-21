import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

abstract class AppColors {
  static const Color kAppPrimaryColor = Color.fromARGB(255, 69, 127, 155);
  static final MaterialColor kPrimarySwatch =
      createMaterialColor(kAppPrimaryColor);

  static MaterialColor createMaterialColor(Color color) {
    List<double> strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;
    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  static const Color kSecondaryColor = Color.fromARGB(255, 255, 80, 191);
  static const Color kSecondaryDarkColor = Color.fromARGB(255, 86, 179, 226);
  static const Color kSecondaryVariant = Color.fromARGB(255, 124, 170, 194);
  static const Color kErrorColor = CupertinoColors.destructiveRed;
  static const Color kErrorColorDark = Color.fromARGB(255, 231, 122, 122);

  static const Color kLightAndroidBackground =
      Color.fromARGB(255, 255, 255, 255);
  static const Color kDarkAndroidBackground = Color(0xFF121212);
  static const Color kLightAndroidSurface = Color.fromARGB(255, 254, 249, 249);
  static const Color kDarkAndroidSurface = Color(0xFF1F1F1F);

  static const Color kLightAndroidOnSurface = Color(0xFF000000);
  static const Color kDarkAndroidOnSurface = Color(0xFFFFFFFF);
  static const Color kDarkAndroidOnPrimary = Color(0xFFFFFFFF);

  static const Color kLightAndroidOnPrimary = Color(0xFFFFFFFF);

  static const Color cupertinoBlackColor = CupertinoColors.black;

  // Прозорі шари для гласморфізму
  static Color glassBackgroundLight = const Color(0xFFF4F4F4).withOpacity(0.9);
  static Color glassBackgroundDark = const Color(0xFF2C2C2C).withOpacity(0.5);
  static Color glassSurfaceLight = const Color(0xFFFFFFFF).withOpacity(0.7);
  static Color glassSurfaceDark = const Color(0xFF1F1F1F).withOpacity(0.6);

  static const Color transparent = Colors.transparent;
}
