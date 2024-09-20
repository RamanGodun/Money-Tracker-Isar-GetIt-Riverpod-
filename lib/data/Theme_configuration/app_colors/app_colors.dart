import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color kAppPrimaryColor = Color.fromARGB(255, 21, 171, 166);
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

  static const Color kSecondaryColor = Color.fromARGB(255, 69, 127, 155);
  static const Color kSecondaryDarkColor = Color.fromARGB(255, 124, 170, 194);
  static const Color kSecondaryVariant = Color.fromARGB(255, 124, 170, 194);

  static const Color kErrorColor = CupertinoColors.destructiveRed;
  static const Color kErrorColorDark = Color.fromARGB(255, 231, 122, 122);
  static const Color kOnErrorColor = Color.fromARGB(255, 3, 40, 34);
  static const Color buttonsColor = Color.fromARGB(255, 18, 55, 36);
  static const Color kSurfaceColorDark = Color.fromARGB(255, 62, 61, 61);
  static const Color cupertinoBlackColor = CupertinoColors.black;
  static const Color transparent = Colors.transparent;
  static const Color inactiveGray = CupertinoColors.inactiveGray;

  static const Color kLightAndroidBackground = Color(0xFFFFFFFF);
  static const Color kLightAndroidSurface = Color(0xFFFFFFFF);
  static const Color kLightAndroidOnSurface = Color(0xFF000000);
  static const Color kLightAndroidOnPrimary = Color(0xFFFFFFFF);

  static const Color kDarkAndroidBackground = Color(0xFF121212);
  static const Color kDarkAndroidSurface = Color(0xFF1F1F1F);
  static const Color kDarkAndroidOnSurface = Color(0xFFFFFFFF);
  static const Color kDarkAndroidOnPrimary = Color(0xFFFFFFFF);

  static const Color white = Color(0xFFFFFFFF);
  static const Color silver = Color(0xFF999A9B);
  static const Color lightGrey = Color(0xFF777777);
  static const Color grey1 = Color(0xFF242424);
  static const Color grey2 = Color(0xFF666666);
  static const Color darkGrey1 = Color(0xFF3A3A3A);
  static const Color darkGrey2 = Color(0xFF454545);
  static const Color darkGrey3 = Color(0xFF343434);
  static const Color darkGrey4 = Color(0xFF1F1F1F);
  static const Color black1 = Color(0xFF000000);
  static const Color black = Color(0xFF1B1B1B);
  static const Color shadow = Color(0xFF999A9B);
  static const Color hover = Color(0xFF525559);
  static const Color black54 = Colors.black54;
  static final Color grey200 = Colors.grey.shade200;
  static final Color grey300 = Colors.grey.shade300;
  static final Color grey500 = Colors.grey.shade500;
  static final Color grey600 = Colors.grey.shade600;
}
