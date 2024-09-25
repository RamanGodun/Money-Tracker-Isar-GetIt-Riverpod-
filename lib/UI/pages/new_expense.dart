import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/UI/components/other_widgets.dart';
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
    final expenseState = ref.watch(expensesInputDataProvider);
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
                AppMiniWidgets.onlyPadding(
                    StyledText.bodyLarge(
                      theme,
                      AppStrings.category,
                      color: isDarkMode
                          ? AppColors.glassSurfaceLight
                          : AppColors.glassSurfaceDark,
                    ),
                    Side.left,
                    20),
                _buildCategoryDropdown(ref, expenseState, context),
                const SizedBox(height: 16),
                AppMiniWidgets.onlyPadding(
                    StyledText.bodyLarge(
                      theme,
                      AppStrings.expenseDate,
                      color: isDarkMode
                          ? AppColors.glassSurfaceLight
                          : AppColors.glassSurfaceDark,
                    ),
                    Side.left,
                    20),
                const SizedBox(height: 3),
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
                      AppMiniWidgets.onlyPadding(
                          StyledText.bodyLarge(
                            theme,
                            AppStrings.category,
                            color: isDarkMode
                                ? AppColors.glassSurfaceLight
                                : AppColors.glassSurfaceDark,
                          ),
                          Side.left,
                          20),
                      _buildCategoryDropdown(ref, expenseState, context)
                    ])),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppMiniWidgets.onlyPadding(
                              StyledText.bodyLarge(
                                theme,
                                AppStrings.expenseDate,
                                color: isDarkMode
                                    ? AppColors.glassSurfaceLight
                                    : AppColors.glassSurfaceDark,
                              ),
                              Side.left,
                              20),
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
    return SizedBox(
      height: 60,
      child: TextField(
        decoration: const InputDecoration(
          labelText: AppStrings.amountSpent,
        ),
        onChanged: (value) =>
            ref.read(expensesInputDataProvider.notifier).updateTitle(value),
      ),
    );
  }

  Widget _buildAmountInputField(WidgetRef ref, expenseState, ThemeData theme) {
    return SizedBox(
      height: 60,
      child: TextField(
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: const InputDecoration(
          labelText: AppStrings.expenseTitle,
        ),
        onChanged: (value) =>
            ref.read(expensesInputDataProvider.notifier).updateAmount(value),
      ),
    );
  }

  Widget _buildCategoryDropdown(
      WidgetRef ref, expenseState, BuildContext context) {
    final theme = Helpers.themeGet(context);
    return AppMiniWidgets.onlyPadding(
        DropdownButton<Category>(
          isDense: true,
          elevation: 3,
          value: expenseState.category,
          items: Category.values
              .map((category) => DropdownMenuItem(
                    value: category,
                    child: StyledText.titleSmall(
                        theme, category.name.toUpperCase(),
                        color: theme.colorScheme.primary),
                  ))
              .toList(),
          onChanged: (value) {
            if (value != null) {
              ref
                  .read(expensesInputDataProvider.notifier)
                  .updateCategory(value);
            }
          },
          borderRadius: AppConstants.radius12,
          style: theme.textTheme.titleSmall,
          iconEnabledColor: theme.colorScheme.primary,
          dropdownColor: theme.colorScheme.surfaceContainer.withOpacity(0.6),
        ),
        Side.left,
        20);
  }

  Widget _buildDatePickerButton(BuildContext context, WidgetRef ref,
      expenseState, bool isDarkMode, ThemeData theme) {
    return TextButton(
      onPressed: () => _presentDatePicker(context, ref),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        backgroundColor: isDarkMode
            ? AppColors.glassSurfaceDark.withOpacity(0.4)
            : AppColors.glassSurfaceLight.withOpacity(0.25),
        shape: AppBordersStyling.roundedRectangleBorder(theme),
      ),
      child: Row(
        children: [
          const Icon(Icons.calendar_month_outlined),
          const SizedBox(width: 12),
          Text(
            expenseState.date == null
                ? AppStrings.noDateSelected
                : '${AppStrings.selectedDate}: ${DateFormat('dd.MM.yyyy').format(expenseState.date!)}',
            style: TextStyling.bodyMedium(theme).copyWith(
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
    ref.read(expensesInputDataProvider.notifier).updateDate(pickedDate);
  }
}
