import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dialogs_service.dart';
import 'exp_dialog_service.dart';
import '../../DATA/data_services/isar_service.dart';
import '../../DATA/data_services/sh_prefs_service.dart';
import 'text_validation_service.dart';

/// The AppServiceLocator class serves as a singleton for managing the app's
/// service dependencies using the GetIt package. It initializes and registers
/// various services (e.g., IsarService, SharedPreferencesService) that can be
/// accessed across the app using the `get` method.
class AppServiceLocator {
  // Private constructor for singleton pattern
  AppServiceLocator._internal();

  // Singleton instance of AppServiceLocator
  static final AppServiceLocator _singleton = AppServiceLocator._internal();

  // Public getter for the singleton instance
  static AppServiceLocator get instance => _singleton;

  // GetIt instance for dependency injection
  final GetIt _getIt = GetIt.instance;

  /// Generic method to retrieve registered services. This allows easy access
  /// to any service registered in the GetIt container by specifying the type `T`.
  /// Example usage: `final isarService = AppServiceLocator.instance.get<IsarService>();`
  T get<T extends Object>() {
    return _getIt.get<T>();
  }

  /// Initializes and registers all necessary services. This method should
  /// be called when the app starts to ensure all services are ready to be used.
  Future<void> initialize() async {
    await _setupIsarService(); // Initialize and register IsarService
    await _setupSharedPreferences(); // Initialize and register SharedPreferencesService
    _setupTextValidation(); // Register TextFieldValidationService
    _setupCustomDialogService(); // Register SettingsDialogService
    _setupAddExpenseDialogService(); // Register ExpenseDialogService
  }

  /// Sets up and registers the IsarService, responsible for managing the
  /// Isar database. This service is registered as a singleton, meaning only
  /// one instance will be used across the app.
  Future<void> _setupIsarService() async {
    if (!_getIt.isRegistered<IsarService>()) {
      final isarService = IsarService();
      await isarService.openDatabase(); // Open the Isar database
      _getIt.registerSingleton<IsarService>(
        isarService,
        dispose: (isarService) => isarService
            .closeIsar(), // Ensure the database is closed when no longer needed
      );
    }
  }

  /// Sets up and registers the SharedPreferencesService, which handles the
  /// storing and retrieving of user preferences (such as theme settings)
  /// using the SharedPreferences package. Registered as a singleton.
  Future<void> _setupSharedPreferences() async {
    if (!_getIt.isRegistered<SharedPreferencesService>()) {
      final prefs = await SharedPreferences
          .getInstance(); // Obtain SharedPreferences instance
      _getIt.registerSingleton<SharedPreferencesService>(
        SharedPreferencesService(
            prefs), // Register SharedPreferencesService with the obtained prefs
      );
    }
  }

  /// Registers the TextFieldValidationService, which provides various methods
  /// for validating text fields in the app (e.g., email validation, phone number validation).
  void _setupTextValidation() {
    if (!_getIt.isRegistered<TextFieldValidationService>()) {
      _getIt.registerSingleton<TextFieldValidationService>(
        TextFieldValidationService(),
      );
    }
  }

  /// Registers the ExpenseDialogService using the lazy singleton approach.
  /// This service is responsible for managing dialogs related to adding or editing expenses.
  void _setupAddExpenseDialogService() {
    if (!_getIt.isRegistered<ExpenseDialogService>()) {
      _getIt.registerLazySingleton(() => ExpenseDialogService());
    }
  }

  /// Registers the SettingsDialogService as a lazy singleton. This service manages
  /// settings-related dialogs (such as theme selection or general app settings).
  void _setupCustomDialogService() {
    if (!_getIt.isRegistered<SettingsDialogService>()) {
      _getIt.registerLazySingleton(() => SettingsDialogService());
    }
  }
}
