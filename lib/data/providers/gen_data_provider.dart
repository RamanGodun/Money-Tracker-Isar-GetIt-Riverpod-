import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/general_data_model.dart';

final generalDataProvider =
    StateNotifierProvider<GeneralDataNotifier, GeneralDataModel>((ref) {
  throw UnimplementedError(
      'generalDataProvider should be overridden in main.dart');
});

class GeneralDataNotifier extends StateNotifier<GeneralDataModel> {
  static const String _chartPreferenceKey = 'isFirstChart';

  GeneralDataNotifier(MediaQueryData mediaQuery)
      : super(
          GeneralDataModel(
            deviceSize: mediaQuery.size,
            isFirstChart: true,
            isPortraitMode: mediaQuery.orientation == Orientation.portrait,
          ),
        );

  // Метод для оновлення MediaQuery
  void updateMediaQuery(MediaQueryData mediaQuery) {
    if (state.deviceSize == mediaQuery.size &&
        state.isPortraitMode ==
            (mediaQuery.orientation == Orientation.portrait)) {
      return;
    }
    state = GeneralDataModel(
      deviceSize: mediaQuery.size,
      isFirstChart: state.isFirstChart,
      isPortraitMode: mediaQuery.orientation == Orientation.portrait,
    );
  }

  // Метод для зміни типу чарту та збереження в SharedPreferences
  Future<void> toggleChart(bool isFirstChart) async {
    if (state.isFirstChart == isFirstChart) {
      return;
    }
// Перевіряємо чи дійсно потрібне оновлення
    state = GeneralDataModel(
      deviceSize: state.deviceSize,
      isFirstChart: isFirstChart,
      isPortraitMode: state.isPortraitMode,
    );
    await _saveChartPreference(isFirstChart);
  }

  // Збереження типу чарту в SharedPreferences
  Future<void> _saveChartPreference(bool isFirstChart) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_chartPreferenceKey, isFirstChart);
    } catch (e) {
      debugPrint('Failed to save chart preference: $e');
    }
  }

  // Завантаження типу чарту з SharedPreferences
  Future<void> loadChartPreference() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstChart = prefs.getBool(_chartPreferenceKey) ?? true;

    if (state.isFirstChart == isFirstChart) return; // Уникаємо зайвих оновлень

    state = GeneralDataModel(
      deviceSize: state.deviceSize,
      isFirstChart: isFirstChart,
      isPortraitMode: state.isPortraitMode,
    );
  }
//
}
