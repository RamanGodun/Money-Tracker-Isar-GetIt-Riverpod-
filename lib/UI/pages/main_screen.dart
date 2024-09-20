import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import '../../data/providers/chart_type_provider.dart';
import '../../data/providers/expenses_provider.dart';
import '../../data/providers/input_data_provider.dart';
import '../../domain/Services/_service_locator.dart';
import '../../domain/Services/animation_controller_service.dart';
import '../../domain/Services/dialogs_service.dart';
import '../../data/helpers/helpers.dart';
import '../../domain/models/expense_model.dart';
import '../components/chart/chart.dart';
import '../components/chart/chart_alt.dart';
import '../components/custom_dialog/custom_dialog.dart';
import '../components/expenses_list/expenses_list.dart';
import '../components/new_expense.dart';
import '../components/settings.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late AnimationService animationService;
  late bool isDarkTheme;
  late ThemeData theme;
  late Size deviceSize;

  @override
  void initState() {
    super.initState();
    animationService = GetIt.instance<AnimationService>();
    animationService.init(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isDarkTheme = Helpers.isDarkMode(context);
    theme = Helpers.themeGet(context);
    deviceSize = Helpers.deviceSizeGet(context);
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = deviceSize.width;
    return Consumer(
      builder: (context, ref, child) {
        final expensesState = ref.watch(expensesNotifierProvider);
        final isFirstChart = ref.watch(chartTypeProvider);

        return Scaffold(
          appBar: AppBar(
            title: Text('Трекер витрат', style: theme.textTheme.displayMedium),
            actions: [
              IconButton(
                onPressed: () => showSettingDialog(context, theme),
                icon: const Icon(Icons.settings),
              )
            ],
          ),
          body: SafeArea(
            child: expensesState.isLoading
                ? Center(
                    child: CircularProgressIndicator.adaptive(
                        backgroundColor: theme.colorScheme.onSurface))
                : expensesState.error != null
                    ? Center(child: Text('Error: ${expensesState.error}'))
                    : deviceWidth < 600
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: isFirstChart
                                    ? Text(
                                        'Динаміка витрат по категоріям',
                                        style: theme.textTheme.bodyLarge,
                                      )
                                    : Text(
                                        'Динаміка витрат за останній тиждень',
                                        style: theme.textTheme.bodyLarge,
                                      ),
                              ),
                              SizedBox(
                                height: deviceSize.height * 0.26,
                                child: isFirstChart
                                    ? Chart(expenses: expensesState.expenses)
                                    : ChartAlt(expensesState.expenses),
                              ),
                              Expanded(
                                child: ExpensesList(
                                  expenses: expensesState.expenses,
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: isFirstChart
                                    ? Chart(expenses: expensesState.expenses)
                                    : ChartAlt(expensesState.expenses),
                              ),
                              Expanded(
                                child: ExpensesList(
                                  expenses: expensesState.expenses,
                                ),
                              ),
                            ],
                          ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 118.0),
            child: FloatingActionButton(
              backgroundColor: theme.colorScheme.primary,
              onPressed: () => _showCustomAddExpenseDialog(context, ref),
              child: const Icon(Icons.add, size: 30),
            ),
          ),
        );
      },
    );
  }

  void showSettingDialog(BuildContext context, ThemeData theme) {
    final dialogService = DIServiceLocator.instance.get<CustomDialogService>();

    dialogService.showDialog(
      context: context,
      title: 'Налаштування',
      content: const SettingsWidget(),
      actions: [
        CupertinoDialogAction(
          textStyle: theme.textTheme.bodyLarge
              ?.copyWith(color: theme.colorScheme.primaryFixed),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Закрити'),
        ),
      ],
    );
  }

  void _showCustomAddExpenseDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      barrierColor: Theme.of(context)
          .colorScheme
          .onTertiaryContainer
          .withOpacity(isDarkTheme ? 0.8 : 0.74),
      builder: (context) {
        return CustomDialog(
          contentWidget: const NewExpense(),
          onActionPressed: () {
            final expenseNotifier = ref.read(newExpenseProvider.notifier);

            if (expenseNotifier.validateData()) {
              // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
              final expenseData = expenseNotifier.state;
              ref.read(expensesNotifierProvider.notifier).addExpense(
                    ExpenseModel(
                      title: expenseData.title,
                      amount: double.parse(expenseData.amount),
                      date: expenseData.date!,
                      category: expenseData.category,
                    ),
                  );
              Navigator.of(context).pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Заповніть всі поля!'),
                  backgroundColor: Colors.redAccent,
                ),
              );
            }
          },
          onCancelPressed: () => Navigator.of(context).pop(),
          dialogTitle: 'Додати нову витрату',
          actionButtonText: 'Зберегти',
          cancelButtonText: 'Відміна',
        );
      },
    );
  }

  @override
  void dispose() {
    animationService.dispose();
    super.dispose();
  }
}
