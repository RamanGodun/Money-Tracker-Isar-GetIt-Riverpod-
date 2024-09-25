import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../DATA/constants/app_constants.dart';
import '../../../DATA/providers/themes_provider.dart';
import '../../../DOMAIN/models/app_enums.dart';
import '../../../DOMAIN/models/expense_model.dart';
import '../../../DOMAIN/models/expenses_bucket_model.dart';
import '../text_widgets.dart';
import '_chart_bar.dart';

class Chart extends ConsumerWidget {
  final List<ExpenseModel> expenses;
  const Chart({super.key, required this.expenses});

  static List<ExpensesBucket> _generateBuckets(List<ExpenseModel> expenses) {
    return [
      Category.food,
      Category.leisure,
      Category.transport,
      Category.work,
      Category.charity,
      Category.health,
      Category.other
    ]
        .map((category) => ExpensesBucket.forCategory(expenses, category))
        .toList();
  }

  static double _calculateMaxTotalExpense(List<ExpenseModel> expenses) {
    double maxTotalExpense = 0;
    final buckets = _generateBuckets(expenses);
    for (final bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }
    return maxTotalExpense;
  }

  static List<double> _calculateCategorySum(List<ExpenseModel> expenses) {
    final buckets = _generateBuckets(expenses);
    return buckets.map((bucket) => bucket.totalExpenses).toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeDataProvider);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;

    return FutureBuilder<Map<String, dynamic>>(
      future: _calculateChartData(expenses),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return const Center(
            child: Text("Error loading chart data"),
          );
        }

        final buckets = snapshot.data!['buckets'] as List<ExpensesBucket>;
        final maxTotalExpense = snapshot.data!['maxTotalExpense'] as double;
        final categorySum1 = snapshot.data!['categorySum1'] as List<double>;

        final categorySum = {
          Category.food: categorySum1[0],
          Category.leisure: categorySum1[1],
          Category.transport: categorySum1[2],
          Category.work: categorySum1[3],
          Category.charity: categorySum1[4],
          Category.health: categorySum1[5],
          Category.other: categorySum1[6],
        };

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
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: buckets.map((bucket) {
                        return ChartBar(
                          fill: bucket.totalExpenses == 0
                              ? 0
                              : bucket.totalExpenses / maxTotalExpense,
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: buckets.map((bucket) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            children: [
                              Icon(
                                categoriesIcons[bucket.category],
                                color: colorScheme.secondary
                                    .withOpacity(isDarkMode ? 0.8 : 0.7),
                              ),
                              StyledText.bodyMedium(
                                  theme,
                                  categorySum[bucket.category]
                                          ?.toStringAsFixed(0) ??
                                      '0'),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<Map<String, dynamic>> _calculateChartData(
      List<ExpenseModel> expenses) async {
    // Попереднє завантаження даних графіка
    final buckets = _generateBuckets(expenses);
    final maxTotalExpense = _calculateMaxTotalExpense(expenses);
    final categorySum1 = _calculateCategorySum(expenses);

    return {
      'buckets': buckets,
      'maxTotalExpense': maxTotalExpense,
      'categorySum1': categorySum1,
    };
  }
}
