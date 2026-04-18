import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileStorageManager {
  static final FileStorageManager _instance = FileStorageManager._();
  factory FileStorageManager() {
    return _instance;
  }
  FileStorageManager._();

  late final Directory _appDocumentsDirectory;
  late final File _tasksFile;

  Future<void> init() async {
    _appDocumentsDirectory = await getApplicationDocumentsDirectory();
    _tasksFile = File('${_appDocumentsDirectory.path}/tasks.json');

    // print(_tasksFile);
  }

  Future<void> saveTasks(List<dynamic> list) async {
    final String tasksJson = jsonEncode(list);
    await _tasksFile.writeAsString(tasksJson);
  }

  Future<List<dynamic>> loadTasks() async {
    if (!await _tasksFile.exists()) return [];

    final String tasksJson = await _tasksFile.readAsString();
    return jsonDecode(tasksJson);
  }

  Future<void> clear() async {
    if (await _tasksFile.exists()) {
      await _tasksFile.delete();
    }
  }
}
