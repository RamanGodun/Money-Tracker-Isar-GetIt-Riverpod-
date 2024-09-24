import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import '../../DATA/providers/expenses_provider.dart';
import '../../DATA/providers/gen_data_provider.dart';
import '../../DATA/providers/input_data_provider.dart';
import '../../DOMAIN/Services/_service_locator.dart';
import '../../DOMAIN/Services/animation_controller_service.dart';
import '../../DOMAIN/Services/dialogs_service.dart';
import '../../DATA/helpers/helpers.dart';
import '../../DOMAIN/models/expense_model.dart';
import '../components/chart/_chart.dart';
import '../components/chart/chart_alt.dart';
import '../components/custom_dialog/custom_dialog.dart';
import '../components/expenses_list/expenses_list.dart';
import '../components/mini_widgets.dart';
import 'new_expense.dart';
import 'settings_widget.dart';

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
    return Consumer(
      builder: (context, ref, child) {
        final expensesState = ref.watch(expensesNotifierProvider);
        final generalData = ref.watch(generalDataProvider);
        // final isFirstChart = ref.watch(chartTypeProvider);
        final isFirstChart = generalData.isFirstChart;

        return Scaffold(
          appBar: AppBar(
            title: const Padding(
              padding: EdgeInsets.only(left: 18.0),
              child: Text('Трекер витрат'),
            ),
            actions: [
              IconButton(
                  onPressed: () =>
                      _openSettingsDialog(context, theme, isDarkTheme),
                  icon: const Icon(Icons.settings)),
              const SizedBox(width: 20)
            ],
          ),
          body: SafeArea(
            child: expensesState.isLoading
                ? const Center(child: CircularProgressIndicator.adaptive())
                : expensesState.error != null
                    ? Center(child: Text('Error: ${expensesState.error}'))
                    : deviceSize.width < 600
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _getGraphicsTitleWidget(
                                  isFirstChart: isFirstChart),
                              _getChartWidget(isFirstChart, expensesState),
                              _getGraphicsTitleWidget(
                                  isListTitle: true,
                                  isFirstChart: isFirstChart),
                              Expanded(
                                child: ExpensesList(
                                    expenses: expensesState.expenses),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: _getChartWidget(
                                    isFirstChart, expensesState),
                              ),
                              Expanded(
                                child: ExpensesList(
                                    expenses: expensesState.expenses),
                              ),
                            ],
                          ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 80.0, right: 15),
            child: FloatingActionButton(
              backgroundColor: theme.colorScheme.primary.withOpacity(0.7),
              onPressed: () => _showCustomAddExpenseDialog(context, ref, theme),
              child: const Icon(Icons.add, size: 30),
            ),
          ),
        );
      },
    );
  }

  Padding _getGraphicsTitleWidget(
      {bool? isListTitle, required bool isFirstChart}) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 25),
      child: (isListTitle != null)
          ? AppMiniWidgets.smallTitle(theme, 'Список витрат')
          : isFirstChart
              ? Text(
                  'Витрати по категоріям',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                )
              : Text(
                  'Витрати за останній тиждень',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
    );
  }

  SizedBox _getChartWidget(bool isFirstChart, expensesState) {
    return SizedBox(
      height: deviceSize.height * 0.26,
      child: isFirstChart
          ? Chart(expenses: expensesState.expenses)
          : ChartAlt(expensesState.expenses),
    );
  }

  void _openSettingsDialog(
      BuildContext context, ThemeData theme, bool isDarkTheme) {
    final dialogService = DIServiceLocator.instance.get<CustomDialogService>();
    dialogService.showCustomDialog(
      context: context,
      title: 'Налаштування',
      content: const SettingsWidget(),
      theme: theme,
      isDarkTheme: isDarkTheme,
    );
  }

  void _showCustomAddExpenseDialog(
      BuildContext context, WidgetRef ref, ThemeData theme) {
    showDialog(
      context: context,
      barrierColor:
          theme.colorScheme.shadow.withOpacity(isDarkTheme ? 0.8 : 0.74),
      builder: (context) {
        return CustomDialog(
          contentWidget: const NewExpense(),
          onActionPressed: () {
            final expenseNotifier = ref.read(newExpenseProvider.notifier);

            if (expenseNotifier.validateData()) {
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
