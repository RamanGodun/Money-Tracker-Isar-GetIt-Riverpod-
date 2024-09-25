import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../DATA/constants/strings_4_app.dart';
import '../../DATA/helpers/helpers.dart';
import '../../DOMAIN/Services/_service_locator.dart';
import '../../DOMAIN/Services/dialogs_service.dart';
import '../../DOMAIN/Services/exp_dialog_service.dart';
import '../../DOMAIN/models/app_enums.dart';
import '../../UI/components/other_widgets.dart';
import '../../DATA/providers/expenses_provider.dart';
import '../../DATA/providers/gen_data_provider.dart';
import '../../DATA/providers/themes_provider.dart';
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
    final isPortraitMode = (Helpers.deviceWidthGet(context) < 600);

    return Scaffold(
      appBar: AppBar(
        title: AppMiniWidgets.onlyPadding(
            const Text(AppStrings.appTitle), Side.left, 18),
        actions: [
          IconButton(
            onPressed: () => _openSettingsDialog(context, theme, isDarkTheme),
            icon: const Icon(Icons.settings),
          ),
          const SizedBox(width: 36),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (expensesState.isLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (expensesState.error != null) {
              return Center(
                child: StyledText.errorText(
                    theme, '${AppStrings.errorMessage}${expensesState.error}'),
              );
            } else if (constraints.maxWidth < 600) {
              return _buildSmallLayout(
                  generalData, expensesState, theme, isFirstChart);
            } else {
              return _buildLargeLayout(
                  generalData, expensesState, theme, isFirstChart);
            }
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
            bottom:
                isPortraitMode ? 100.0 : Helpers.deviceHeightGet(context) * 0.6,
            right: 15),
        child: FloatingActionButton(
          mini: true,
          backgroundColor: theme.colorScheme.primary.withOpacity(0.7),
          onPressed: () {
            final dialogService =
                DIServiceLocator.instance.get<ExpenseDialogService>();
            dialogService.showAddOrEditExpenseDialog(context, ref);
          },
          child: const Icon(Icons.add, size: 30),
        ),
      ),
    );
  }

  Widget _buildSmallLayout(
      generalData, expensesState, ThemeData theme, bool isFirstChart) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getGraphicsTitleWidget(theme, isFirstChart: isFirstChart),
        _getChartWidget(generalData, expensesState),
        _getGraphicsTitleWidget(
          theme,
          isListTitle: true,
          isFirstChart: isFirstChart,
        ),
        Expanded(child: ExpensesList(expenses: expensesState.expenses)),
      ],
    );
  }

  Widget _buildLargeLayout(
      generalData, expensesState, ThemeData theme, bool isFirstChart) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getGraphicsTitleWidget(theme, isFirstChart: isFirstChart),
              _getChartWidget(generalData, expensesState),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getGraphicsTitleWidget(
                theme,
                isListTitle: true,
                isFirstChart: isFirstChart,
              ),
              Expanded(child: ExpensesList(expenses: expensesState.expenses)),
            ],
          ),
        ),
      ],
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
          : generalData.deviceSize.height * 0.7,
      child: FutureBuilder(
        future: Future.delayed(const Duration(milliseconds: 10)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return generalData.isFirstChart
              ? Chart(expenses: expensesState.expenses)
              : ChartAlt(expensesState.expenses);
        },
      ),
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
}
