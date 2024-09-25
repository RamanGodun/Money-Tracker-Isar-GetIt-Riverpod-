import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dialogs_service.dart';
import 'exp_dialog_service.dart';
import 'isar_service.dart';
import 'sh_prefs_service.dart';
import 'text_validation_service.dart';

class DIServiceLocator {
  DIServiceLocator._internal();
  static final DIServiceLocator _singleton = DIServiceLocator._internal();
  static DIServiceLocator get instance => _singleton;
  final GetIt _getIt = GetIt.instance;

  Future<void> setupDependencies() async {
    await _setupIsarService();
    await _setupSharedPreferences();
    // _setupAnimationService();
    _setupTextValidation();
    _setupCustomDialogService();
    _setupAddExpenseDialogService();
  }

  Future<void> _setupIsarService() async {
    if (!_getIt.isRegistered<IsarService>()) {
      final isarService = IsarService();
      await isarService.initializeIsar();

      _getIt.registerSingleton<IsarService>(
        isarService,
        dispose: (isarService) => isarService.closeIsar(),
      );
    }
  }

  void _setupAddExpenseDialogService() {
    if (!_getIt.isRegistered<ExpenseDialogService>()) {
      _getIt.registerSingleton<ExpenseDialogService>(ExpenseDialogService());
    }
  }

  Future<void> _setupSharedPreferences() async {
    if (!_getIt.isRegistered<SharedPreferencesService>()) {
      final prefs = await SharedPreferences.getInstance();
      _getIt.registerSingleton<SharedPreferencesService>(
        SharedPreferencesService(prefs),
      );
    }
  }

  void _setupTextValidation() {
    if (!_getIt.isRegistered<TextFieldValidationService>()) {
      _getIt.registerSingleton<TextFieldValidationService>(
        TextFieldValidationService(),
      );
    }
  }

  void _setupCustomDialogService() {
    if (!_getIt.isRegistered<SettingsDialogService>()) {
      _getIt.registerSingleton<SettingsDialogService>(
        SettingsDialogService(),
      );
    }
  }

  // void _setupAnimationService() {
  //   if (!_getIt.isRegistered<AnimationService>()) {
  //     _getIt.registerSingleton<AnimationService>(
  //       AnimationService(),
  //     );
  //   }
  // }

  T get<T extends Object>() {
    return _getIt.get<T>();
  }
}
