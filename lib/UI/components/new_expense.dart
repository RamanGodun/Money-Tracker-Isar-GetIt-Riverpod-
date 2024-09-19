import 'package:flutter/material.dart';
import '../../domain/Services/text_validation_service.dart';
import '../../domain/models/category_model.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return NewExpenseState(); // Використовуємо публічний клас
  }
}

class NewExpenseState extends State<NewExpense> {
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  String? _titleError;
  String? _amountError;

  Map<String, dynamic> getExpenseData() {
    return {
      'title': _titleController.text,
      'amount': _amountController.text,
      'category': _selectedCategory,
      'date': _selectedDate,
    };
  }

  bool validateExpenseData() {
    bool isValid = true;

    // Валідація назви
    final titleValidation = TextFieldValidationService.validateString(
        _titleController.text, false, 3);
    if (titleValidation != null) {
      setState(() {
        _titleError = titleValidation;
      });
      isValid = false;
    } else {
      setState(() {
        _titleError = null;
      });
    }

    // Валідація суми
    final amountValidation =
        TextFieldValidationService.validateDouble(_amountController.text, 1);
    if (amountValidation != null) {
      setState(() {
        _amountError = amountValidation;
      });
      isValid = false;
    } else {
      setState(() {
        _amountError = null;
      });
    }

    // Валідація дати
    if (_selectedDate == null) {
      isValid = false;
    }

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _titleController,
          maxLength: 50,
          decoration: InputDecoration(
            labelText: 'Назва витрати',
            errorText: _titleError,
          ),
        ),
        TextField(
          controller: _amountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: 'Потрачено, грн',
            errorText: _amountError,
          ),
        ),
        Row(
          children: [
            DropdownButton<Category>(
              value: _selectedCategory,
              items: Category.values
                  .map(
                    (category) => DropdownMenuItem(
                      value: category,
                      child: Text(category.name.toUpperCase()),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedCategory = value;
                  });
                }
              },
            ),
            TextButton(
              onPressed: _presentDatePicker,
              child: Text(
                _selectedDate == null
                    ? 'Виберіть дату'
                    : 'Дата: ${_selectedDate!.toLocal()}',
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1),
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }
}
