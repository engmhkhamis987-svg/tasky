import 'package:flutter/material.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/models/task_model.dart';

class HomeController extends ChangeNotifier {
  String? userName;
  List<TaskModel> tasks = [];
  bool isLoading = false;
  String? userImagePath;
  // int totalTasks = 0;
  // int doneTasks = 0;
  // double percent = 0;

  void init() {
    loadUserData();
    // loadTasks();
  }

  Future<void> loadUserData() async {
    userName = PreferencesManager().getString(StorageKey.username) ?? '';
    userImagePath = PreferencesManager().getString(StorageKey.userImage);
    notifyListeners();
  }

  // Future<void> loadTasks() async {
  //   isLoading = true;
  //   notifyListeners();

  //   final finalTasks = PreferencesManager().getString(StorageKey.tasks);
  //   if (finalTasks != null) {
  //     final List<dynamic> tasksAfterDecode = jsonDecode(finalTasks);

  //     tasks = tasksAfterDecode.map((task) => TaskModel.fromMap(task)).toList();

  //     calculateProgress();
  //   }

  //   isLoading = false;
  //   notifyListeners();
  // }

  // void calculateProgress() {
  //   totalTasks = tasks.length;
  //   doneTasks = tasks.where((e) => e.isDone).length;
  //   percent = totalTasks == 0 ? 0 : (doneTasks / totalTasks);
  // }

  // Future<void> doneTask(bool? val, int? index) async {
  //   tasks[index!].isDone = val ?? false;
  //   calculateProgress();

  //   final String encodedData = jsonEncode(
  //     tasks.map((task) => task.toMap()).toList(),
  //   );
  //   await PreferencesManager().setString(StorageKey.tasks, encodedData);

  //   notifyListeners();
  // }

  // Future<void> deleteTask(int id) async {
  //   tasks.removeWhere((task) => task.id == id);

  //   calculateProgress();

  //   final String updatedTasks = jsonEncode(
  //     tasks.map((task) => task.toMap()).toList(),
  //   );
  //   await PreferencesManager().setString(StorageKey.tasks, updatedTasks);
  //   notifyListeners();
  // }
}
