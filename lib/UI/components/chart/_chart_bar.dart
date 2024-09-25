import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../DATA/constants/app_box_decoration.dart';
import '../../../DATA/providers/themes_provider.dart';

class ChartBar extends ConsumerWidget {
  final double fill;
  const ChartBar({super.key, required this.fill});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeDataProvider);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FractionallySizedBox(
          heightFactor: fill,
          widthFactor: 0.5,
          child: DecoratedBox(
            decoration: AppBoxDecorations.forGraphics(theme, true),
          ),
        ),
      ),
    );
  }
}
