import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

Future<void> initHive() async {
  final directory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(directory.path);
}
