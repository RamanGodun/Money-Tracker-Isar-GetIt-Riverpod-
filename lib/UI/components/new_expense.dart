import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/Theme_configuration/app_colors/app_colors.dart';
import '../../data/providers/input_data_provider.dart';
import '../../domain/models/app_enums.dart';
import '../../domain/models/category_model.dart';

class NewExpense extends ConsumerWidget {
  const NewExpense({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenseState = ref.watch(newExpenseProvider);
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleInputField(ref, expenseState, theme),
        const SizedBox(height: 16),
        _buildAmountInputField(ref, expenseState, theme),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildCategoryDropdown(ref, expenseState),
            const SizedBox(width: 16),
            _buildDatePickerButton(context, ref, expenseState, isDarkTheme),
          ],
        ),
      ],
    );
  }

  Widget _buildTitleInputField(WidgetRef ref, expenseState, ThemeData theme) {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Назва витрати',
        labelStyle: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.onSurface.withOpacity(0.7),
        ),
        filled: true,
        fillColor: theme.colorScheme.surface.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: theme.colorScheme.primary.withOpacity(0.3),
          ),
        ),
        errorText:
            expenseState.title.isEmpty ? 'Це поле не може бути пустим' : null,
      ),
      onChanged: (value) =>
          ref.read(newExpenseProvider.notifier).updateTitle(value),
    );
  }

  Widget _buildAmountInputField(WidgetRef ref, expenseState, ThemeData theme) {
    return TextField(
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Потрачено, грн',
        labelStyle: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.onSurface.withOpacity(0.7),
        ),
        filled: true,
        fillColor: theme.colorScheme.surface.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: theme.colorScheme.primary.withOpacity(0.3),
          ),
        ),
        errorText:
            expenseState.amount.isEmpty ? 'Це поле не може бути пустим' : null,
      ),
      onChanged: (value) =>
          ref.read(newExpenseProvider.notifier).updateAmount(value),
    );
  }

  Widget _buildCategoryDropdown(WidgetRef ref, expenseState) {
    return DropdownButton<Category>(
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
      borderRadius: BorderRadius.circular(12),
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      dropdownColor: Colors.white.withOpacity(0.85),
      underline: const SizedBox(),
    );
  }

  Widget _buildDatePickerButton(
      BuildContext context, WidgetRef ref, expenseState, bool isDarkTheme) {
    return TextButton(
      onPressed: () => _presentDatePicker(context, ref),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        backgroundColor: isDarkTheme
            ? AppColors.glassSurfaceDark
            : AppColors.glassSurfaceLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        expenseState.date == null
            ? 'Виберіть дату'
            : 'Дата: ${expenseState.date!.toLocal()}',
        style: TextStyle(
          fontSize: 16,
          color: isDarkTheme ? Colors.white : Colors.black87,
        ),
      ),
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
