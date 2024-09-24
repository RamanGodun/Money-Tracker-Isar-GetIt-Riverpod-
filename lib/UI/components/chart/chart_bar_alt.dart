import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/DATA/constants/app_text_styling.dart';
import '../../../DATA/themes_set/themes_provider.dart';

class ChartBarAlt extends ConsumerWidget {
  final String label;
  final double spendingMoney;
  final double spendingPctOfTotal;

  const ChartBarAlt(this.label, this.spendingMoney, this.spendingPctOfTotal,
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeDataProvider);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;

    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: <Widget>[
          SizedBox(
            height: constraints.maxHeight * 0.15,
            child: Wrap(
              children: [
                FittedBox(
                  child: StyledText.bodyMedium(
                      theme, "${spendingMoney.toStringAsFixed(0)} ₴"),
                ),
              ],
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
          SizedBox(
            height: constraints.maxHeight * 0.6,
            width: 20,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color:
                        theme.canvasColor.withOpacity(isDarkMode ? 0.6 : 0.5),
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPctOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(12)),
                      color: colorScheme.secondary
                          .withOpacity(isDarkMode ? 0.8 : 0.6),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
          SizedBox(
            height: constraints.maxHeight * 0.15,
            child: StyledText.bodyMedium(theme, label),
          ),
        ],
      );
    });
  }
}
