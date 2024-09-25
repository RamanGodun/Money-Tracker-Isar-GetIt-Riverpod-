import 'package:flutter/material.dart';
import '../../DATA/constants/app_constants.dart';
import '../../DATA/constants/app_text_styling.dart';

class ExpenseTextField extends StatefulWidget {
  final String label;
  final String? errorText;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;

  const ExpenseTextField({
    required this.label,
    this.errorText,
    required this.controller,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
    super.key,
  });

  @override
  State<ExpenseTextField> createState() => _ExpenseTextFieldState();
}

class _ExpenseTextFieldState extends State<ExpenseTextField> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: AppConstants.heightForComponent,
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          labelText: widget.label,
          errorText: widget.errorText,
          labelStyle: TextStyling.labelForTextField(theme, widget.errorText),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
