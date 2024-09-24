import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../DATA/themes_set/themes_provider.dart';

class ChartBar extends ConsumerWidget {
  final double fill;
  const ChartBar({super.key, required this.fill});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeDataProvider);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;

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
              color: colorScheme.secondary.withOpacity(isDarkMode ? 0.8 : 0.6),
            ),
          ),
        ),
      ),
    );
  }
}
