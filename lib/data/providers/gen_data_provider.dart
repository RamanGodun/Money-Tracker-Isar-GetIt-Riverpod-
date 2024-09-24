import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../domain/models/general_data_model.dart';

class GeneralDataNotifier extends StateNotifier<GeneralDataModel> {
  GeneralDataNotifier()
      : super(
          GeneralDataModel(
            deviceSize: const MediaQueryData().size,
            isFirstChart: true,
            isPortraitMode: true,
          ),
        );

  void updateMediaQuery(MediaQueryData mediaQuery) {
    state = GeneralDataModel(
      deviceSize: const MediaQueryData().size,
      isFirstChart: state.isFirstChart,
      isPortraitMode: mediaQuery.orientation == Orientation.portrait,
    );
  }

  void toggleChart(bool isFirstChart) {
    state = GeneralDataModel(
      deviceSize: state.deviceSize,
      isFirstChart: isFirstChart,
      isPortraitMode: state.isPortraitMode,
    );
  }
}

final generalDataProvider =
    StateNotifierProvider<GeneralDataNotifier, GeneralDataModel>((ref) {
  return GeneralDataNotifier();
});
