import 'package:flutter/material.dart';
import 'package:money_tracker/UI/pages/main_screen.dart';
import 'package:money_tracker/data/helpers/helpers.dart';

import '_buttons_styling.dart';

class AppButtons {
/* WITH SHADOWS
 */
  static Widget goToQuestionManager(BuildContext context) {
    return AppButtonsStyling.inIOSStyle(
      context,
      onPressed: () {
        Helpers.push(context, const MainScreen());
        // context.pushNamed('QuestionHandler');
      },
      buttonText: "To Questions Manager",
    );
  }

/* 
*/
}
