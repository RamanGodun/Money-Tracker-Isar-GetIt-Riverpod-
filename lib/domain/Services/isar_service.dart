import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';

class IsarService {
  late Isar isar;

  Future<void> initializeIsar() async {
    // ignore: unused_local_variable
    final dir = await getApplicationSupportDirectory();
    // isar = await Isar.open([DBItemSchema], directory: dir.path);
  }
}
