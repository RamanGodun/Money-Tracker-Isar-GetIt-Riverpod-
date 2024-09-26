import 'package:flutter/material.dart';
import '../../UI/themes_configuration/app_colors.dart';

/// A widget that displays a basic error screen.
/// It is used to handle app crashes or critical errors by showing an error message.
class ErrorScreen extends StatelessWidget {
  final String errorDescription;
  const ErrorScreen({super.key, required this.errorDescription});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            'Error occurred: $errorDescription', // You could consider making this text translatable.
            style: const TextStyle(color: AppColors.errorColor, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
