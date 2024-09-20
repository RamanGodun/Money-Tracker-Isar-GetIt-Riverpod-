import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/providers/input_data_provider.dart';
import '../../domain/models/category_model.dart';

class NewExpense extends ConsumerWidget {
  const NewExpense({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenseState = ref.watch(newExpenseProvider);

    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Назва витрати',
            errorText: expenseState.title.isEmpty
                ? 'Це поле не може бути пустим'
                : null,
          ),
          onChanged: (value) =>
              ref.read(newExpenseProvider.notifier).updateTitle(value),
        ),
        TextField(
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: 'Потрачено, грн',
            errorText: expenseState.amount.isEmpty
                ? 'Це поле не може бути пустим'
                : null,
          ),
          onChanged: (value) =>
              ref.read(newExpenseProvider.notifier).updateAmount(value),
        ),
        Row(
          children: [
            DropdownButton<Category>(
              value: expenseState.category,
              items: Category.values
                  .map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name.toUpperCase()),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  ref.read(newExpenseProvider.notifier).updateCategory(value);
                }
              },
            ),
            TextButton(
              onPressed: () => _presentDatePicker(context, ref),
              child: Text(
                expenseState.date == null
                    ? 'Виберіть дату'
                    : 'Дата: ${expenseState.date!.toLocal()}',
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _presentDatePicker(BuildContext context, WidgetRef ref) async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1),
      lastDate: now,
    );
    ref.read(newExpenseProvider.notifier).updateDate(pickedDate);
  }
}
