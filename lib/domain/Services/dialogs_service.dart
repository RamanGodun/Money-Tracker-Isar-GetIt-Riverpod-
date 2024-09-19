import 'package:flutter/cupertino.dart';

class CustomDialogService {
  void showDialog({
    required BuildContext context,
    required String title,
    required Widget content,
    required List<Widget> actions,
  }) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: content,
          actions: actions,
        );
      },
    );
  }
}
