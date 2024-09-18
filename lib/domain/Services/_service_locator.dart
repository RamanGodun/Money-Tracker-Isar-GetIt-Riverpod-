import 'package:get_it/get_it.dart';

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
  GetIt get getIt => _getIt;

  Future<void> setupDependencies() async {
    await _setupIsarService();
    _setupAnimationService();
    _setupTextValidation();
    _setupCustomDialogService();
    _setupStaticWidgets();
  }

/*TextFieldValidationService */
  void _setupTextValidation() {
    if (!_getIt.isRegistered<TextFieldValidationService>()) {
      _getIt.registerSingleton<TextFieldValidationService>(
          TextFieldValidationService());
    }
  }

  void _setupCustomDialogService() {
    if (!_getIt.isRegistered<CustomDialogService>()) {
      _getIt.registerSingleton<CustomDialogService>(CustomDialogService());
    }
  }

  void _setupStaticWidgets() {
    if (!_getIt.isRegistered<AppCashedWidgets1>()) {
      getIt.registerSingleton<AppCashedWidgets1>(AppCashedWidgets1());
    }
  }

  Future<void> _setupIsarService() async {
    if (!_getIt.isRegistered<IsarService>()) {
      final isarService = IsarService();
      await isarService.initializeIsar();
      _getIt.registerSingleton<IsarService>(isarService);
    }
  }

  void _setupAnimationService() {
    if (!_getIt.isRegistered<AnimationService>()) {
      _getIt.registerSingleton<AnimationService>(AnimationService());
    }
  }

  T get<T extends Object>() {
    return _getIt.get<T>();
  }
}
