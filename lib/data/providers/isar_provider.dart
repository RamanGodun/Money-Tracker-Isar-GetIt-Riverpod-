import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../DOMAIN/Services/_service_locator.dart';
import '../../DOMAIN/Services/isar_service.dart';

final isarServiceProvider = Provider<IsarService>((ref) {
  final isarService = DIServiceLocator.instance.get<IsarService>();
  return isarService;
});
