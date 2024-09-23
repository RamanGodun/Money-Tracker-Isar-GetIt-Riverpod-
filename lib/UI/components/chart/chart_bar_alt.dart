import 'package:flutter/material.dart';

import '../../../DATA/helpers/helpers.dart';

class ChartBarAlt extends StatelessWidget {
  final String label;
  final double spendingMoney;
  final double spendingPctOfTotal;

  const ChartBarAlt(this.label, this.spendingMoney, this.spendingPctOfTotal,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Helpers.themeGet(context);
    final isDarkMode = Helpers.isDarkMode(context);

    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: <Widget>[
          SizedBox(
            height: constraints.maxHeight * 0.15,
            child: Wrap(
              children: [
                FittedBox(
                  child: Text("${spendingMoney.toStringAsFixed(1)}₴"),
                ),
              ],
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
          SizedBox(
            height: constraints.maxHeight * 0.6,
            width: 10,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color:
                        theme.canvasColor.withOpacity(isDarkMode ? 0.9 : 0.7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPctOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: theme.colorScheme.primaryFixed,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
          SizedBox(
            height: constraints.maxHeight * 0.15,
            child: Text(
              label,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      );
    });
  }
}
