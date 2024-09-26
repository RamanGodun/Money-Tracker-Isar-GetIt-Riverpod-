import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/UI/components/text_widgets.dart';
import '../../DATA/constants/app_constants.dart';
import '../../DATA/constants/app_text_styling.dart';
import '../../DATA/constants/app_strings.dart';
import '../../DATA/helpers/helpers.dart';
import '../../DOMAIN/providers/input_data_provider.dart';
import '../../DOMAIN/providers/themes_provider.dart';
import '../../DATA/models/app_enums.dart';
import '../../DATA/models/expense_model.dart';
import '../../DATA/models/expenses_input_state.dart';

class NewOrEditExpense extends ConsumerStatefulWidget {
  final ExpenseModel? initialExpense;

  const NewOrEditExpense({super.key, this.initialExpense});

  @override
  ConsumerState<NewOrEditExpense> createState() => _NewOrEditExpenseState();
}

class _NewOrEditExpenseState extends ConsumerState<NewOrEditExpense> {
  late TextEditingController _titleController;
  late TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _amountController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.initialExpense != null) {
      Future(() {
        ref
            .read(expenseInputProvider.notifier)
            .setInitialExpense(widget.initialExpense!);
        _titleController.text = widget.initialExpense!.title;
        _amountController.text = widget.initialExpense!.amount.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final expenseState = ref.watch(expenseInputProvider);
    final theme = ref.watch(themeDataProvider);
    final isDarkMode = theme.brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return Padding(
            padding: AppConstants.paddingCommon,
            child: ListView(
              children: [
                _buildTextFieldsWidgets(ref, expenseState, theme),
                const SizedBox(height: 16),
                _buildCategoryAndDateWidgets(
                    context, ref, expenseState, theme, isDarkMode),
              ],
            ),
          );
        } else {
          return Padding(
            padding: AppConstants.paddingCommon,
            child: Row(
              children: [
                Expanded(
                    child: _buildTextFieldsWidgets(ref, expenseState, theme)),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildCategoryAndDateWidgets(
                      context, ref, expenseState, theme, isDarkMode),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildTextFieldsWidgets(
      WidgetRef ref, NewExpenseState expenseState, ThemeData theme) {
    return Column(
      children: [
        const SizedBox(height: 15),
        _buildTitleInputField(ref, expenseState, theme),
        const SizedBox(height: 12),
        _buildAmountInputField(ref, expenseState, theme),
      ],
    );
  }

  Widget _buildCategoryAndDateWidgets(BuildContext context, WidgetRef ref,
      NewExpenseState expenseState, ThemeData theme, bool isDarkMode) {
    return Padding(
      padding: AppConstants.paddingHorizontal18,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StyledText.bodyMedium(theme, AppStrings.category),
          _buildCategoryDropdown(ref, expenseState, context),
          const SizedBox(height: 16),
          StyledText.bodyMedium(theme, AppStrings.expenseDate),
          _buildDatePickerButton(context, ref, expenseState, isDarkMode, theme),
        ],
      ),
    );
  }

  Widget _buildTitleInputField(
      WidgetRef ref, NewExpenseState expenseState, ThemeData theme) {
    final errorText = ref.watch(expenseInputProvider.notifier).titleError;

    return SizedBox(
      height: AppConstants.heightCommon,
      child: TextField(
        controller: _titleController,
        decoration: InputDecoration(
          labelText: AppStrings.expenseTitle,
          errorText: errorText,
          labelStyle: TextStyling.labelForTextField(theme, errorText),
        ),
        onChanged: (value) {
          ref.read(expenseInputProvider.notifier).updateTitle(value);
        },
      ),
    );
  }

  Widget _buildAmountInputField(
      WidgetRef ref, NewExpenseState expenseState, ThemeData theme) {
    final errorText = ref.watch(expenseInputProvider.notifier).amountError;

    return SizedBox(
      height: AppConstants.heightCommon,
      child: TextField(
        controller: _amountController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: AppStrings.amountSpent,
          errorText: errorText,
          labelStyle: TextStyling.labelForTextField(theme, errorText),
        ),
        onChanged: (value) {
          ref.read(expenseInputProvider.notifier).updateAmount(value);
        },
      ),
    );
  }

  Widget _buildCategoryDropdown(
      WidgetRef ref, NewExpenseState expenseState, BuildContext context) {
    final theme = Helpers.getTheme(context);
    return DropdownButton<Category>(
      value: expenseState.category,
      items: Category.values.map((category) {
        return DropdownMenuItem(
          value: category,
          child: StyledText.titleSmall(theme, category.name.toUpperCase(),
              color: theme.colorScheme.secondary),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          ref.read(expenseInputProvider.notifier).updateCategory(value);
        }
      },
    );
  }

  Widget _buildDatePickerButton(BuildContext context, WidgetRef ref,
      NewExpenseState expenseState, bool isDarkMode, ThemeData theme) {
    return TextButton(
      onPressed: () => _presentDatePicker(context, ref),
      child: Row(
        children: [
          const Icon(Icons.calendar_month_outlined),
          const SizedBox(width: 12),
          StyledText.datePickerText(theme, expenseState),
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
    ref.read(expenseInputProvider.notifier).updateDate(pickedDate);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
