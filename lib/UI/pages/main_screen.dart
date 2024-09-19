import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import '../../data/providers/chart_type_provider.dart';
import '../../data/providers/expenses_provider.dart';
import '../../domain/Services/_service_locator.dart';
import '../../domain/Services/animation_controller_service.dart';
import '../../domain/Services/dialogs_service.dart';
import '../../domain/helpers/helpers.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final expensesState = ref.watch(expensesNotifierProvider);
        final widthMQ = MediaQuery.of(context).size.width;
        final isFirstChart = ref.watch(chartTypeProvider);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Трекер витрат'),
            actions: [
              IconButton(
                onPressed: () {
                  final dialogService =
                      DIServiceLocator.instance.get<CustomDialogService>();

                  dialogService.showDialog(
                    context: context,
                    title: 'Налаштування',
                    content: const SettingsWidget(),
                    actions: [
                      CupertinoDialogAction(
                        child: const Text('Закрити'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
                icon: const Icon(Icons.settings),
              ),
            ],
          ),
          body: SafeArea(
            child: expensesState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : expensesState.error != null
                    ? Center(child: Text('Error: ${expensesState.error}'))
                    : widthMQ < 600
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: isFirstChart
                                    ? Text(
                                        'Динаміка витрат по категоріям',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      )
                                    : Text(
                                        'Динаміка витрат за останній тиждень',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                              ),
                              Expanded(
                                // Відображаємо обраний чарт
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
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showCustomAddExpenseDialog(context, ref),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  void _showCustomAddExpenseDialog(BuildContext context, WidgetRef ref) {
    final newExpenseState = GlobalKey<NewExpenseState>();

    showDialog(
      context: context,
      barrierColor: Theme.of(context)
          .colorScheme
          .onTertiaryContainer
          .withOpacity(isDarkTheme ? 0.85 : 0.74),
      builder: (context) {
        return CustomDialog(
          contentWidget: NewExpense(key: newExpenseState),
          onActionPressed: () {
            final expenseState = newExpenseState.currentState;
            if (expenseState != null) {
              // Викликаємо метод валідації
              final isValid = expenseState.validateExpenseData();
              // Якщо дані валідні, додаємо витрату
              if (isValid) {
                final expenseData = expenseState.getExpenseData();
                ref.read(expensesNotifierProvider.notifier).addExpense(
                      ExpenseModel(
                        title: expenseData['title'],
                        amount: double.parse(expenseData['amount']),
                        date: expenseData['date'],
                        category: expenseData['category'],
                      ),
                    );
                Navigator.of(context).pop();
              }
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
