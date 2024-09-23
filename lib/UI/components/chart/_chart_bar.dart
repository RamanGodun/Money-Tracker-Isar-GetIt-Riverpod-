import 'package:flutter/material.dart';

import '../../../DATA/helpers/helpers.dart';

class ChartBar extends StatelessWidget {
  final double fill;
  const ChartBar({
    super.key,
    required this.fill,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Helpers.themeGet(context);
    final isDarkMode = Helpers.isDarkMode(context);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FractionallySizedBox(
          heightFactor: fill,
          widthFactor: 0.5,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              color:
                  theme.colorScheme.secondary.withOpacity(isDarkMode ? 1 : 0.6),
            ),
          ),
        ),
      ),
    );
  }
}
