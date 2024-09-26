import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../DATA/constants/app_box_decoration.dart';
import '../../../DOMAIN/providers/themes_provider.dart';

/// ChartBar is a widget that represents a single bar in a bar chart.
/// The bar is drawn based on the `fill` value, which determines how much of the
/// bar is filled proportionally relative to the maximum value.
class ChartBar extends ConsumerWidget {
  final double fillRatio;

  const ChartBar({super.key, required this.fillRatio});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeDataProvider);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FractionallySizedBox(
          heightFactor: fillRatio, // Determines how much of the bar is filled
          widthFactor: 0.5,
          child: DecoratedBox(
            decoration: AppBoxDecorations.forGraphics(theme, true),
          ),
        ),
      ),
    );
  }
}
