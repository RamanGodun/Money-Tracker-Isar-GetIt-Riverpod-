import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../DATA/constants/app_constants.dart';
import '../../../DATA/helpers/helpers.dart';
import '../../../DOMAIN/providers/themes_provider.dart';
import '../../../DATA/models/app_enums.dart';
import '../../../DATA/models/expense_model.dart';
import '../../../DATA/models/expenses_bucket_model.dart';
import '../text_widgets.dart';
import '_chart_bar.dart';

/// Widget that displays a chart representing the total expenses per category.
/// The chart is divided into bars where each bar corresponds to a category.
/// The height of the bars reflects the total expenses for that category.
class CategoryBasedChart extends ConsumerWidget {
  final List<ExpenseModel> expenses;

  const CategoryBasedChart({super.key, required this.expenses});

  /// Generates a list of `ExpensesBucket` objects for each category and calculates
  /// the maximum total expense at the same time. Returns both the buckets and max expense.
  static Map<String, dynamic> _prepareChartData(List<ExpenseModel> expenses) {
    List<ExpensesBucket> buckets = [];
    double maxTotalExpense = 0;

    for (var category in Category.values) {
      final bucket = ExpensesBucket.forCategory(expenses, category);
      buckets.add(bucket);
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }

    return {'buckets': buckets, 'maxTotalExpense': maxTotalExpense};
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeDataProvider);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;

    final data = _prepareChartData(expenses);
    final buckets = data['buckets'] as List<ExpensesBucket>;
    final maxTotalExpense = data['maxTotalExpense'] as double;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          width: double.infinity,
          height: constraints.maxHeight * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [
                colorScheme.secondary.withOpacity(0.3),
                colorScheme.secondary.withOpacity(0.0),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Column(
            children: [
              // Display the bars of the chart
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: _buildChartBars(buckets, maxTotalExpense),
                ),
              ),
              const SizedBox(height: 12),
              // Display icons and total expenses for each category
              Row(
                children:
                    _buildCategoryIconsAndSums(buckets, theme, isDarkMode),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Builds the bars of the chart based on the total expenses for each category.
  List<Widget> _buildChartBars(
      List<ExpensesBucket> buckets, double maxTotalExpense) {
    return buckets.map((bucket) {
      return ChartBar(
        fillRatio: bucket.totalExpenses == 0
            ? 0
            : bucket.totalExpenses / maxTotalExpense,
      );
    }).toList();
  }

  /// Builds the icons and total expense text for each category.
  List<Widget> _buildCategoryIconsAndSums(
      List<ExpensesBucket> buckets, ThemeData theme, bool isDarkMode) {
    final colorScheme = theme.colorScheme;

    return buckets.map((bucket) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Column(
            children: [
              Icon(
                expenseCategoryIcons[bucket.category],
                color:
                    colorScheme.secondary.withOpacity(isDarkMode ? 0.8 : 0.7),
              ),
              StyledText.bodySmall(
                theme,
                Helpers().formatAmount(bucket.totalExpenses),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}
