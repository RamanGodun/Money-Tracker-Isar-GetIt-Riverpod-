import 'package:flutter/material.dart';

import '../themes_set/app_themes/app_colors.dart';

class ErrorApp extends StatelessWidget {
  final String errorMessage;

  const ErrorApp({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            'Error occurred: $errorMessage',
            style: const TextStyle(color: AppColors.kErrorColor, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
