import 'package:flutter/material.dart';

class ChartBarAlt extends StatelessWidget {
  final String label;
  final double spendingMoney;
  final double spendingPctOfTotal;

  const ChartBarAlt(this.label, this.spendingMoney, this.spendingPctOfTotal,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
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
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          SizedBox(
            height: constraints.maxHeight * 0.6,
            width: 10,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Theme.of(context).canvasColor.withOpacity(0.3)
                        : Theme.of(context).primaryColor,
                    border: Border.all(
                      width: 0.03,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPctOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isDarkMode ? Colors.green : Colors.amber,
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
