import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../DATA/constants/app_box_decoration.dart';
import '../../../DATA/helpers/helpers.dart';
import '../../../DOMAIN/providers/themes_provider.dart';
import '../text_widgets.dart';

/// `ChartBarAlt` displays an individual bar in a chart, representing
/// a single day’s spending amount compared to the total weekly spending.
class ChartBarAlt extends ConsumerWidget {
  final String label;
  final double dailySpentAmount;
  final double spendingPercentage;

  const ChartBarAlt(this.label, this.dailySpentAmount, this.spendingPercentage,
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeDataProvider);

    return LayoutBuilder(builder: (context, constraints) {
      // Use Column for vertically aligned content (amount, bar, label)
      return Column(
        children: <Widget>[
          // Display the formatted spending amount in a fitted box to adapt to the available space
          SizedBox(
            height: 20,
            child: FittedBox(
              child: StyledText.bodyMedium(
                theme,
                Helpers().formatAmount(dailySpentAmount),
              ),
            ),
          ),
          const SizedBox(height: 5),
          // Bar that visually represents the percentage of total spending
          SizedBox(
            height: constraints.maxHeight * 0.7,
            width: 20,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                // Background bar (empty)
                Container(
                  decoration: AppBoxDecorations.forGraphics(theme, false),
                ),
                // Filled portion of the bar (based on percentage of total spending)
                FractionallySizedBox(
                  heightFactor: spendingPercentage,
                  child: Container(
                    decoration: AppBoxDecorations.forGraphics(theme, true),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          // Display the label (e.g., day of the week)
          SizedBox(
            height: 20,
            child: StyledText.bodyMedium(
              theme,
              label,
              color: theme.colorScheme.secondaryFixedDim,
            ),
          ),
        ],
      );
    });
  }
}
