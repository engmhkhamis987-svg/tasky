import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/models/task_model.dart';

class HiveStorageManager {
  static final HiveStorageManager _instance = HiveStorageManager._();
  factory HiveStorageManager() {
    return _instance;
  }
  HiveStorageManager._();

  late Box<TaskModel> _taskBox;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskModelAdapter());
    _taskBox = await Hive.openBox<TaskModel>(StorageKey.taskNameCollection);
  }

  Future<void> saveTasks(List<TaskModel> list) async {
    await _taskBox.clear();
    await _taskBox.addAll(list);
    // for (final task in list) {
    //   await _taskBox.add(task);
    // }
  }

  List<TaskModel> loadTasks() {
    return _taskBox.values.toList();
  }

  Future<void> clear() async {
    await _taskBox.clear();
  }
}
