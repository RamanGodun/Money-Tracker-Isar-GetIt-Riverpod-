import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../DATA/constants/app_borders.dart';
import '../../DATA/constants/app_constants.dart';
import '../../DATA/constants/app_text_styling.dart';
import '../../DATA/constants/strings_4_app.dart';
import '../../DATA/helpers/helpers.dart';
import '../../DATA/providers/input_data_provider.dart';
import '../../DATA/providers/gen_data_provider.dart';
import '../../DATA/themes_set/app_themes/app_colors.dart';
import '../../DATA/themes_set/themes_provider.dart';
import '../../DOMAIN/models/app_enums.dart';
import '../components/text_widgets.dart';

class NewExpense extends ConsumerWidget {
  const NewExpense({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenseState = ref.watch(newExpenseProvider);
    final theme = ref.watch(themeDataProvider);
    final isDarkMode = theme.brightness == Brightness.dark;
    final generalData = ref.watch(generalDataProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: (generalData.deviceSize.width < 600)
            ? [
                _buildTitleInputField(ref, expenseState, theme),
                const SizedBox(height: 12),
                _buildAmountInputField(ref, expenseState, theme),
                const SizedBox(height: 16),
                StyledText.titleSmall(theme, AppStrings.category),
                _buildCategoryDropdown(ref, expenseState, context),
                const SizedBox(height: 16),
                StyledText.titleSmall(theme, AppStrings.expenseDate),
                _buildDatePickerButton(
                    context, ref, expenseState, isDarkMode, theme),
              ]
            : [
                Row(
                  children: [
                    Expanded(
                        child: _buildTitleInputField(ref, expenseState, theme)),
                    const SizedBox(width: 12),
                    Expanded(
                        child:
                            _buildAmountInputField(ref, expenseState, theme)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                        child: Column(children: [
                      StyledText.titleSmall(theme, AppStrings.category),
                      _buildCategoryDropdown(ref, expenseState, context)
                    ])),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StyledText.titleSmall(theme, AppStrings.expenseDate),
                          _buildDatePickerButton(
                              context, ref, expenseState, isDarkMode, theme),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
      ),
    );
  }

  Widget _buildTitleInputField(WidgetRef ref, expenseState, ThemeData theme) {
    return TextField(
      decoration: InputDecoration(
        labelText: AppStrings.expenseTitle,
        labelStyle: TextStyling.bodyLarge(theme),
        filled: true,
        fillColor: theme.colorScheme.surface.withOpacity(0.3),
        border: AppBordersStyling.inputFieldBorder(theme),
        errorText:
            expenseState.title.isEmpty ? AppStrings.emptyFieldError : null,
      ),
      onChanged: (value) =>
          ref.read(newExpenseProvider.notifier).updateTitle(value),
    );
  }

  Widget _buildAmountInputField(WidgetRef ref, expenseState, ThemeData theme) {
    return TextField(
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: AppStrings.amountSpent,
        labelStyle: TextStyling.bodyLarge(theme),
        filled: true,
        fillColor: theme.colorScheme.surface.withOpacity(0.3),
        border: AppBordersStyling.inputFieldBorder(theme),
        errorText:
            expenseState.amount.isEmpty ? AppStrings.emptyFieldError : null,
      ),
      onChanged: (value) =>
          ref.read(newExpenseProvider.notifier).updateAmount(value),
    );
  }

  Widget _buildCategoryDropdown(
      WidgetRef ref, expenseState, BuildContext context) {
    final theme = Helpers.themeGet(context);
    return DropdownButton<Category>(
      value: expenseState.category,
      items: Category.values
          .map((category) => DropdownMenuItem(
                value: category,
                child:
                    StyledText.titleSmall(theme, category.name.toUpperCase()),
              ))
          .toList(),
      onChanged: (value) {
        if (value != null) {
          ref.read(newExpenseProvider.notifier).updateCategory(value);
        }
      },
      borderRadius: AppConstants.radius12,
      style: theme.textTheme.titleMedium,
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
        shape: AppBordersStyling.roundedRectangleBorder(theme),
      ),
      child: Row(
        children: [
          const Icon(Icons.calendar_month_outlined),
          const SizedBox(width: 12),
          Text(
            expenseState.date == null
                ? AppStrings.noDateSelected
                : '${AppStrings.selectedDate}: ${expenseState.date!.toLocal()}',
            style: TextStyling.bodyLarge(theme).copyWith(
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
