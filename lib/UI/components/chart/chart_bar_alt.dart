import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../DATA/constants/app_box_decoration.dart';
import '../../../DATA/providers/themes_provider.dart';
import '../text_widgets.dart';

class ChartBarAlt extends ConsumerWidget {
  final String label;
  final double spendingMoney;
  final double spendingPctOfTotal;

  const ChartBarAlt(this.label, this.spendingMoney, this.spendingPctOfTotal,
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeDataProvider);

    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: <Widget>[
          SizedBox(
            height: constraints.maxHeight * 0.15,
            child: Wrap(
              children: [
                FittedBox(
                  child: StyledText.bodyMedium(
                    theme,
                    "${spendingMoney.toStringAsFixed(0)} ₴",
                  ),
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
                  decoration: AppBoxDecorations.forGraphics(theme, false),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPctOfTotal,
                  child: Container(
                    decoration: AppBoxDecorations.forGraphics(theme, true),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
          SizedBox(
            height: constraints.maxHeight * 0.15,
            child: StyledText.bodyMedium(theme, label,
                color: theme.colorScheme.secondaryFixedDim),
          ),
        ],
      );
    });
  }
}
