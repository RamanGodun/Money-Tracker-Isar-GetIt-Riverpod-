import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/Services/_service_locator.dart';
import '../../domain/Services/isar_service.dart';

// Провайдер для IsarService
final isarServiceProvider = Provider<IsarService>((ref) {
  final isarService = DIServiceLocator.instance.get<IsarService>();
  return isarService;
});
