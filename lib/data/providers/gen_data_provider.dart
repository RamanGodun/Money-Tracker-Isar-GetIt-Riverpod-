import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/general_data_model.dart';

final generalDataProvider =
    StateNotifierProvider<GeneralDataNotifier, GeneralDataModel>((ref) {
  return GeneralDataNotifier()..loadChartPreference();
});

class GeneralDataNotifier extends StateNotifier<GeneralDataModel> {
  static const String _chartPreferenceKey = 'isFirstChart';

  GeneralDataNotifier()
      : super(
          GeneralDataModel(
            deviceSize: const MediaQueryData().size,
            isFirstChart: true,
            isPortraitMode: true,
          ),
        );

  // Метод для оновлення MediaQuery
  void updateMediaQuery(MediaQueryData mediaQuery) {
    state = GeneralDataModel(
      deviceSize: mediaQuery.size,
      isFirstChart: state.isFirstChart,
      isPortraitMode: mediaQuery.orientation == Orientation.portrait,
    );
  }

  // Метод для зміни типу чарту та збереження в SharedPreferences
  Future<void> toggleChart(bool isFirstChart) async {
    state = GeneralDataModel(
      deviceSize: state.deviceSize,
      isFirstChart: isFirstChart,
      isPortraitMode: state.isPortraitMode,
    );
    await _saveChartPreference(isFirstChart);
  }

  // Збереження типу чарту в SharedPreferences
  Future<void> _saveChartPreference(bool isFirstChart) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_chartPreferenceKey, isFirstChart);
  }

  // Завантаження типу чарту з SharedPreferences
  Future<void> loadChartPreference() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstChart = prefs.getBool(_chartPreferenceKey) ?? true;
    state = GeneralDataModel(
      deviceSize: state.deviceSize,
      isFirstChart: isFirstChart,
      isPortraitMode: state.isPortraitMode,
    );
  }
}
