import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/models/category_model.dart';
import '../../domain/models/expenses_model.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(ExpenseModel expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // Class vars next
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // local vars
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    //
    Widget dropdownButtonWidget = DropdownButton(
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
        if (value == null) {
          return;
        }
        setState(() {
          _selectedCategory = value;
        });
      },
    );

    List<Widget> twoButtonsWidget = [
      TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Відміна')),
      ElevatedButton(
        onPressed: _submitExpenseData,
        child: const Text('Зберегти'),
      ),
    ];

    Widget datePickerWidget = Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            _selectedDate == null
                ? 'Дату не обрано'
                : formatter.format(_selectedDate!),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          IconButton(
            onPressed: _presentDatePicker,
            icon: Icon(Icons.calendar_month,
                color: isDarkMode ? Colors.yellow : Colors.amber),
          ),
        ],
      ),
    );

    Widget getTextFieldWidget({required bool isTitle}) {
      return TextField(
        controller: isTitle ? _titleController : _amountController,
        maxLength: isTitle ? 50 : null,
        decoration: InputDecoration(
          label: Text(isTitle ? 'Назва витрати' : 'Потрачено, грн'),
        ),
      );
    }

    return LayoutBuilder(builder: (ctx, constrains) {
      final availableWidth = constrains.maxWidth;

      return SizedBox(
        height: double.infinity,
        width: availableWidth,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                (availableWidth < 600)
                    ? const SizedBox(height: 150)
                    : const SizedBox(height: 50),
                (availableWidth >= 600)
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: getTextFieldWidget(isTitle: true),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: getTextFieldWidget(isTitle: false),
                          ),
                        ],
                      )
                    : getTextFieldWidget(isTitle: true),
                //
                (availableWidth >= 600)
                    ? Row(children: [
                        dropdownButtonWidget,
                        const SizedBox(width: 24),
                        datePickerWidget,
                      ])
                    : Row(children: [
                        Expanded(child: getTextFieldWidget(isTitle: false)),
                        const SizedBox(width: 16),
                        datePickerWidget,
                      ]),
                const SizedBox(height: 16),
                //
                (availableWidth >= 600)
                    ? Row(children: [
                        const Spacer(),
                        ...twoButtonsWidget,
                      ])
                    : Row(children: [
                        dropdownButtonWidget,
                        const Spacer(),
                        ...twoButtonsWidget,
                      ]),
              ],
            ),
          ),
        ),
      );
      //
    });
  }

  // METHODS next
  @override
  void dispose() {
    // calls automatically, when widget&it's state are destroyed (remove from UI)
    _titleController.dispose();
    _amountController.dispose();
    // we need to do that (to delete controller), because TextEditingController lives in memory
    //even when Widget is not visible anymore
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      // without 'await' showDatePicker (Future<DateTime?> Object) returns immediately,
      //but doesn't contained picked value
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog();
      return;
    }

    widget.onAddExpense(
      ExpenseModel(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  void _showDialog() {
    final dialogContent = _buildCustomDialogDependingOnPlatform(
      'Некоректні дані',
      'Будь ласка, переконайтесь, що всі дані введено і вони коректні',
      [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Добре'),
        ),
      ],
    );

    Platform.isIOS
        ? showCupertinoDialog(context: context, builder: (ctx) => dialogContent)
        : showDialog(context: context, builder: (ctx) => dialogContent);
  }

  //Local WIDGETS next
  Widget _buildCustomDialogDependingOnPlatform(
      String title, String content, List<Widget> actions) {
    return Platform.isIOS
        ? CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: actions,
          )
        : AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: actions,
          );
  }
  //
}
