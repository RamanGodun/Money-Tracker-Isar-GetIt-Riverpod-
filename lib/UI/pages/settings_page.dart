import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/Theme_configuration/Themes_provider/themes_provider.dart';

class SettingsWidget extends ConsumerWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    // final screensSize = Helpers.deviceSizeGet(context);

    return Column(
      children: [
        const Switcher(),
        Expanded(
          child: SwitchListTile(
            title: Text(
              'Switch to ${themeMode == ThemeMode.light ? 'Dark' : 'Light'} Theme',
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
            ),
            value: themeMode == ThemeMode.dark,
            onChanged: (value) {
              ref.read(themeProvider.notifier).toggleTheme(value);
            },
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          ),
        ),
      ],
    );
  }
}

class Switcher extends StatefulWidget {
  const Switcher({super.key});

  @override
  State<Switcher> createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher> {
  bool showAltChart = false;

  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
      value: showAltChart,
      onChanged: (val) {
        setState(() {
          showAltChart = val;
        });
      },
    );
  }
}
