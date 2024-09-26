import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Services/_service_locator.dart';
import '../../DATA/data_services/isar_service.dart';

/// Provides the `IsarService` for database operations.
final isarServiceProvider = Provider<IsarService>((ref) {
  final isarService = AppServiceLocator.instance.get<IsarService>();
  return isarService;
});
