import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../DATA/constants/app_strings.dart';
import '../../DATA/helpers/helpers.dart';
import '../../DATA/models/app_enums.dart';
import '../../DOMAIN/Services/_service_locator.dart';
import '../../DOMAIN/Services/dialogs_service.dart';
import '../../DOMAIN/Services/exp_dialog_service.dart';
import '../../UI/components/other_widgets.dart';
import '../../DOMAIN/providers/expenses_provider.dart';
import '../../DOMAIN/providers/gen_data_provider.dart';
import '../../DOMAIN/providers/themes_provider.dart';
import '../components/chart/_chart.dart';
import '../components/chart/chart_alt.dart';
import '../components/expenses_list/expenses_list.dart';
import '../components/text_widgets.dart';
import 'app_settings.dart';

/// MainScreen is the entry point after the app starts.
/// It displays the list of expenses and chart views, allowing the user to interact with expense data.
class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Triggers screen size updates when the layout changes.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final mediaQuery = MediaQuery.of(context);
      ref.read(appGeneralDataProvider.notifier).updateMediaQuery(mediaQuery);
    });

    final generalData = ref.watch(appGeneralDataProvider);
    final isFirstChart = generalData.isFirstChart;
    final theme = ref.watch(themeDataProvider);
    final isDarkTheme = theme.brightness == Brightness.dark;
    final expensesState = ref.watch(expenseManagementProvider);
    final isPortraitMode = (Helpers.getDeviceWidth(context) < 600);

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
              // Shows a loading indicator when data is being loaded
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (expensesState.error != null) {
              // Displays an error message if the expense state contains an error
              return Center(
                child: StyledText.errorText(
                    theme, '${AppStrings.errorMessage}${expensesState.error}'),
              );
            } else {
              // Builds the layout based on orientation (portrait or landscape)
              return _buildResponsiveLayout(
                isPortrait: constraints.maxWidth < 600,
                generalData: generalData,
                expensesState: expensesState,
                theme: theme,
                isFirstChart: isFirstChart,
              );
            }
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
            bottom:
                isPortraitMode ? 100.0 : Helpers.getDeviceHeight(context) * 0.6,
            right: 15),
        child: FloatingActionButton(
          mini: true,
          backgroundColor: theme.colorScheme.primary.withOpacity(0.7),
          onPressed: () {
            final dialogService =
                AppServiceLocator.instance.get<ExpenseDialogService>();
            dialogService.showAddOrEditExpenseDialog(context, ref);
          },
          child: const Icon(Icons.add, size: 30),
        ),
      ),
    );
  }

  /// Builds the layout of the main screen, adjusting for both portrait and landscape modes.
  /// It organizes the chart and expense list depending on the orientation.
  Widget _buildResponsiveLayout({
    required bool isPortrait,
    required generalData,
    required expensesState,
    required ThemeData theme,
    required bool isFirstChart,
  }) {
    return isPortrait
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(theme, isFirstChart: isFirstChart),
              _buildExpenseChart(generalData, expensesState),
              _buildHeader(theme,
                  isListTitle: true, isFirstChart: isFirstChart),
              Expanded(
                  child: ExpensesList(expensesList: expensesState.expenses)),
            ],
          )
        : Row(
            children: [
              Flexible(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(theme, isFirstChart: isFirstChart),
                    _buildExpenseChart(generalData, expensesState),
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(theme,
                        isListTitle: true, isFirstChart: isFirstChart),
                    Expanded(
                        child:
                            ExpensesList(expensesList: expensesState.expenses)),
                  ],
                ),
              ),
            ],
          );
  }

  /// Displays the title above the chart or expense list, depending on the context.
  Padding _buildHeader(ThemeData theme,
      {bool? isListTitle, required bool isFirstChart}) {
    final titleText = (isListTitle == true)
        ? AppStrings.purchasesList
        : isFirstChart
            ? AppStrings.categoryExpenses
            : AppStrings.weeklyExpenses;
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 40, top: 10),
      child: StyledText.titleSmall(theme, titleText),
    );
  }

  /// Builds the chart widget, which adapts to show either category-based or weekly expenses.
  /// The chart adjusts its height depending on the screen orientation.
  SizedBox _buildExpenseChart(generalData, expensesState) {
    final chartHeight = generalData.isPortraitMode
        ? generalData.deviceSize.height * 0.26
        : generalData.deviceSize.height * 0.7;
    return SizedBox(
      height: chartHeight,
      child: FutureBuilder(
        future: Future.delayed(const Duration(milliseconds: 10)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return generalData.isFirstChart
              ? CategoryBasedChart(expenses: expensesState.expenses)
              : Last7DaysChart(expensesState.expenses);
        },
      ),
    );
  }

  /// Opens the settings dialog, allowing the user to adjust app settings, such as switching themes.
  void _openSettingsDialog(
      BuildContext context, ThemeData theme, bool isDarkTheme) {
    final dialogService =
        AppServiceLocator.instance.get<SettingsDialogService>();
    dialogService.showCustomDialog(
      context: context,
      title: AppStrings.settings,
      content: const SettingsWidget(),
      isDarkTheme: isDarkTheme,
    );
  }
}
