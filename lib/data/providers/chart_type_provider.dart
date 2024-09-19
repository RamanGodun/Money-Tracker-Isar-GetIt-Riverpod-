import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final chartTypeProvider = StateNotifierProvider<ChartTypeNotifier, bool>((ref) {
  return ChartTypeNotifier();
});

class ChartTypeNotifier extends StateNotifier<bool> {
  static const _chartPreferenceKey = 'chart_type';

  ChartTypeNotifier() : super(true) {
    _loadChartTypeFromPreferences();
  }

  // Завантажуємо тип чарту з SharedPreferences
  Future<void> _loadChartTypeFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool(_chartPreferenceKey) ?? true;
  }

  // Змінюємо тип чарту та зберігаємо в SharedPreferences
  Future<void> toggleChartType(bool isFirstChart) async {
    state = isFirstChart;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_chartPreferenceKey, state);
  }
}
