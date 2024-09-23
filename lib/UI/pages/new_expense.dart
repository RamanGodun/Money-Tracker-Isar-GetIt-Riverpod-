import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../DATA/Theme_configuration/app_colors/app_colors.dart';
import '../../DATA/helpers/helpers.dart';
import '../../DATA/providers/input_data_provider.dart';
import '../../DOMAIN/models/app_enums.dart';
import '../../DOMAIN/models/category_model.dart';

class NewExpense extends ConsumerWidget {
  const NewExpense({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenseState = ref.watch(newExpenseProvider);
    final theme = Helpers.themeGet(context);
    final isDarkMode = Helpers.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          _buildTitleInputField(ref, expenseState, theme),
          const SizedBox(height: 12),
          _buildAmountInputField(ref, expenseState, theme),
          const SizedBox(height: 12),
          _buildCategoryDropdown(ref, expenseState, theme),
          const SizedBox(height: 12),
          _buildDatePickerButton(context, ref, expenseState, isDarkMode, theme),
        ],
      ),
    );
  }

  Widget _buildTitleInputField(WidgetRef ref, expenseState, ThemeData theme) {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Назва витрати',
        labelStyle: theme.textTheme.bodyLarge,
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
        labelStyle: theme.textTheme.bodyLarge,
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

  Widget _buildCategoryDropdown(WidgetRef ref, expenseState, ThemeData theme) {
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
      style: theme.textTheme.titleSmall,
      iconEnabledColor: theme.colorScheme.primary,
      dropdownColor: theme.colorScheme.surfaceContainer,
    );
  }

  Widget _buildDatePickerButton(BuildContext context, WidgetRef ref,
      expenseState, bool isDarkMode, ThemeData theme) {
    return TextButton(
      onPressed: () => _presentDatePicker(context, ref),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        backgroundColor: isDarkMode
            ? AppColors.glassSurfaceDark
            : AppColors.glassSurfaceLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.calendar_month_outlined),
          const SizedBox(width: 12),
          Text(
            expenseState.date == null
                ? 'Виберіть дату'
                : 'Дата: ${expenseState.date!.toLocal()}',
            style: theme.textTheme.bodyLarge?.copyWith(
                color: expenseState.date == null
                    ? theme.colorScheme.error
                    : theme.colorScheme.secondary),
          ),
        ],
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
