import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../DATA/data_services/sh_prefs_service.dart';
import '../../DATA/models/general_data_model.dart';
import '../Services/_service_locator.dart';

/// StateNotifierProvider to manage general device and app data (e.g., screen sizes, isFirstChart etc).
///
/// This provider creates an instance of [GeneralDataNotifier] to manage the state of the general
/// app-related data. It provides a reactive interface for components that rely on device properties
/// like screen size and orientation, as well as user preferences (e.g., preferred chart type).
///
/// The `ref` provides access to other dependencies, such as services and providers. Here, the
/// `SharedPreferencesService` is fetched via `AppServiceLocator`.
final appGeneralDataProvider =
    StateNotifierProvider<GeneralDataNotifier, GeneralDataModel>((ref) {
  return GeneralDataNotifier(
    mediaQuery: MediaQueryData.fromView(PlatformDispatcher
        .instance.views.first), // Get initial media query data
    sharedPreferencesService: AppServiceLocator.instance.get<
        SharedPreferencesService>(), // Retrieve shared preferences service via GetIt
  );
});

/// [GeneralDataNotifier] manages the general app state, which includes properties
/// like device size, screen orientation, and the user's preferred chart type.
///
/// This class extends [StateNotifier], which allows it to hold and modify state
/// (in this case, a [GeneralDataModel]). The state is exposed to the app through
/// the Riverpod provider `appGeneralDataProvider`.
class GeneralDataNotifier extends StateNotifier<GeneralDataModel> {
  final SharedPreferencesService _sharedPreferencesService;

  /// Constructor that initializes the notifier with initial media query data
  /// and shared preferences service.
  ///
  /// The initial state is set with the device size, chart type (defaulted to `true`),
  /// and the current screen orientation (portrait/landscape).
  GeneralDataNotifier({
    required MediaQueryData mediaQuery,
    required SharedPreferencesService sharedPreferencesService,
  })  : _sharedPreferencesService = sharedPreferencesService,
        super(
          GeneralDataModel(
            deviceSize: mediaQuery.size, // Set device size based on media query
            isFirstChart: true, // Default chart type
            isPortraitMode: mediaQuery.orientation ==
                Orientation.portrait, // Set portrait mode based on media query
          ),
        ) {
    // Load the saved chart type from shared preferences
    loadChartPreference();
  }

  /// Updates the [MediaQueryData] when the device's screen orientation or size changes.
  ///
  /// This method checks whether the new screen size or orientation differs from the current
  /// state. If they differ, the state is updated to reflect the new size and orientation.
  /// Otherwise, it does nothing to avoid unnecessary state changes.
  void updateMediaQuery(MediaQueryData mediaQuery) {
    if (state.deviceSize == mediaQuery.size &&
        state.isPortraitMode ==
            (mediaQuery.orientation == Orientation.portrait)) {
      return; // No changes, return early
    }

    // Update state with new screen size and orientation
    state = GeneralDataModel(
      deviceSize: mediaQuery.size,
      isFirstChart: state.isFirstChart, // Retain the current chart preference
      isPortraitMode: mediaQuery.orientation ==
          Orientation.portrait, // Update orientation mode
    );
  }

  /// Toggles the preferred chart type and saves the preference using [SharedPreferencesService].
  ///
  /// If the chart type hasn't changed, the method returns early. Otherwise, it updates the
  /// state and saves the new chart preference in shared preferences using the
  /// [_sharedPreferencesService].
  Future<void> toggleChart(bool isFirstChart) async {
    if (state.isFirstChart == isFirstChart) {
      return; // No change, return early
    }

    // Update state with new chart preference
    state = GeneralDataModel(
      deviceSize: state.deviceSize,
      isFirstChart: isFirstChart,
      isPortraitMode: state.isPortraitMode,
    );

    // Save new chart preference to shared preferences
    await _sharedPreferencesService.saveChartPreference(isFirstChart);
  }

  /// Loads the chart preference from [SharedPreferencesService].
  ///
  /// This method fetches the saved chart preference from shared preferences. If a
  /// saved preference exists and differs from the current state, it updates the state
  /// to reflect the saved preference.
  Future<void> loadChartPreference() async {
    try {
      // Load chart preference from shared preferences
      final isFirstChart = _sharedPreferencesService.loadChartPreference() ??
          true; // Default to true if no preference is found

      // If the loaded preference differs from the current state, update the state
      if (state.isFirstChart != isFirstChart) {
        state = GeneralDataModel(
          deviceSize: state.deviceSize,
          isFirstChart: isFirstChart,
          isPortraitMode: state.isPortraitMode,
        );
      }
    } catch (e) {
      // Log any errors that occur while loading the preference
      debugPrint('Failed to load chart preference: $e');
    }
  }
}
