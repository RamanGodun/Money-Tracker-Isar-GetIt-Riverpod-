import 'dart:ui';
import 'package:flutter/material.dart';

import '../../data/Theme_configuration/app_colors/app_colors.dart';
import '../../data/Theme_configuration/others/app_styling_constants.dart';

class AppMiniWidgets {
/*
Checkbox
 */
  static Widget emptyCheckBox() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
        color: AppColors.kSecondaryColor,
        width: 0.5,
      )),
      height: 25,
      width: 25,
    );
  }

/*
  "IsAnswerCorrectIdentifier" Widget
 */
  static Widget isAnswerCorrectIdentifier({
    required int questionIndex,
    required bool isCorrectAnswer,
    required BuildContext context,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final questionNumber = questionIndex + 1;
    final backgroundColor = isCorrectAnswer
        ? AppColors.kAppPrimaryColor.withOpacity(0.2)
        : colorScheme.error.withOpacity(0.2);

    return Container(
      width: 100,
      height: 18,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(60), bottomRight: Radius.circular(50)),
      ),
      child: Text(
        questionNumber.toString(),
        style: theme.textTheme.displayLarge
            ?.copyWith(fontSize: 16, color: colorScheme.onSurface),
      ),
    );
  }

/*
OTHERS (borders)
*/
  static Widget backDropFilter({required Widget child}) {
    return ClipRRect(
      borderRadius: AppStylingConstants.radius12,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: child,
      ),
    );
  }
//
}
