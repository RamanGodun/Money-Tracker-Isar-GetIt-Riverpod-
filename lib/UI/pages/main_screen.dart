import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../DATA/constants/strings_4_app.dart';
import '../../DOMAIN/Services/_service_locator.dart';
import '../../DOMAIN/Services/dialogs_service.dart';
import '../../DOMAIN/Services/exp_dialog_service.dart';
import '../../DOMAIN/models/app_enums.dart';
import '../../UI/components/other_widgets.dart';
import '../../DATA/providers/expenses_provider.dart';
import '../../DATA/providers/gen_data_provider.dart';
import '../../DATA/themes_set/themes_provider.dart';
import '../components/chart/_chart.dart';
import '../components/chart/chart_alt.dart';
import '../components/expenses_list/expenses_list.dart';
import '../components/text_widgets.dart';
import 'settings_widget.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Оновлюємо розмір екрана при зміні залежностей
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final mediaQuery = MediaQuery.of(context);
      ref.read(generalDataProvider.notifier).updateMediaQuery(mediaQuery);
    });

    final generalData = ref.watch(generalDataProvider);
    final isFirstChart = generalData.isFirstChart;
    final theme = ref.watch(themeDataProvider);
    final isDarkTheme = theme.brightness == Brightness.dark;
    final expensesState = ref.watch(expensesNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: AppMiniWidgets.onlyPadding(
            const Text(AppStrings.appTitle), Side.left, 18),
        actions: [
          IconButton(
            onPressed: () => _openSettingsDialog(context, theme, isDarkTheme),
            icon: const Icon(Icons.settings),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        child: expensesState.isLoading
            ? const Center(child: CircularProgressIndicator.adaptive())
            : expensesState.error != null
                ? Center(
                    child: StyledText.errorText(theme,
                        '${AppStrings.errorMessage}${expensesState.error}'))
                : generalData.isPortraitMode
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _getGraphicsTitleWidget(theme,
                              isFirstChart: isFirstChart),
                          _getChartWidget(generalData, expensesState),
                          _getGraphicsTitleWidget(
                            theme,
                            isListTitle: true,
                            isFirstChart: isFirstChart,
                          ),
                          Expanded(
                              child: ExpensesList(
                                  expenses: expensesState.expenses)),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                _getGraphicsTitleWidget(theme,
                                    isFirstChart: isFirstChart),
                                _getChartWidget(generalData, expensesState),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                _getGraphicsTitleWidget(
                                  theme,
                                  isListTitle: true,
                                  isFirstChart: isFirstChart,
                                ),
                                Expanded(
                                    child: ExpensesList(
                                        expenses: expensesState.expenses)),
                              ],
                            ),
                          ),
                        ],
                      ),
      ),
      // floatingActionButton
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80.0, right: 15),
        child: FloatingActionButton(
          backgroundColor: theme.colorScheme.primary.withOpacity(0.7),
          onPressed: () {
            final dialogService =
                DIServiceLocator.instance.get<ExpenseDialogService>();
            dialogService.showAddExpenseDialog(context, ref);
          },
          child: const Icon(Icons.add, size: 30),
        ),
      ),
    );
  }

  Padding _getGraphicsTitleWidget(ThemeData theme,
      {bool? isListTitle, required bool isFirstChart}) {
    return Padding(
        padding: const EdgeInsets.only(right: 20, left: 40, top: 10),
        child: (isListTitle != null)
            ? StyledText.titleSmall(theme, AppStrings.purchasesList)
            : isFirstChart
                ? StyledText.titleSmall(theme, AppStrings.categoryExpenses)
                : StyledText.titleSmall(theme, AppStrings.weeklyExpenses));
  }

  SizedBox _getChartWidget(generalData, expensesState) {
    return SizedBox(
      height: generalData.isPortraitMode
          ? generalData.deviceSize.height * 0.26
          : generalData.deviceSize.height * 0.6,
      child: generalData.isFirstChart
          ? Chart(expenses: expensesState.expenses)
          : ChartAlt(expensesState.expenses),
    );
  }

  void _openSettingsDialog(
      BuildContext context, ThemeData theme, bool isDarkTheme) {
    final dialogService =
        DIServiceLocator.instance.get<SettingsDialogService>();
    dialogService.showCustomDialog(
      context: context,
      title: AppStrings.settings,
      content: const SettingsWidget(),
      isDarkTheme: isDarkTheme,
    );
  }
//
}
