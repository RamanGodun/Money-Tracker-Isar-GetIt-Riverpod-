import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../UI/components/cashed_on_get_it.dart';
import 'animation_controller_service.dart';
import 'dialogs_service.dart';
import 'isar_service.dart';
import 'text_validation_service.dart';

class DIServiceLocator {
  DIServiceLocator._internal();
  static final DIServiceLocator _singleton = DIServiceLocator._internal();

  static DIServiceLocator get instance => _singleton;

  final GetIt _getIt = GetIt.instance;

  Future<void> setupDependencies() async {
    await _setupIsarService();
    await _setupSharedPreferences();
    _setupAnimationService();
    _setupTextValidation();
    _setupCustomDialogService();
    _setupStaticWidgets();
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

  Future<void> _setupSharedPreferences() async {
    if (!_getIt.isRegistered<SharedPreferences>()) {
      final prefs = await SharedPreferences.getInstance();
      _getIt.registerSingleton<SharedPreferences>(prefs);
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
    if (!_getIt.isRegistered<CustomDialogService>()) {
      _getIt.registerSingleton<CustomDialogService>(
        CustomDialogService(),
      );
    }
  }

  void _setupStaticWidgets() {
    // Реєструємо кешовані віджети
    if (!_getIt.isRegistered<AppCashedWidgets1>()) {
      _getIt.registerSingleton<AppCashedWidgets1>(AppCashedWidgets1());
    }
  }

  void _setupAnimationService() {
    if (!_getIt.isRegistered<AnimationService>()) {
      _getIt.registerSingleton<AnimationService>(
        AnimationService(),
      );
    }
  }

  T get<T extends Object>() {
    return _getIt.get<T>();
  }
}
