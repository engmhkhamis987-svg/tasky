import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/models/task_model.dart';

class TasksController with ChangeNotifier {
  bool isLoading = false;

  List<TaskModel> tasks = [];
  List<TaskModel> todoTasks = [];
  List<TaskModel> completedTasks = [];
  List<TaskModel> highPriorityTasks = [];

  // int totalTasks = 0;
  // int doneTasks = 0;
  // double percent = 0;

  void init() {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    isLoading = true;
    notifyListeners();

    final finalTasks = PreferencesManager().getString(StorageKey.tasks);
    if (finalTasks != null) {
      final List<dynamic> tasksAfterDecode = jsonDecode(finalTasks);

      tasks = tasksAfterDecode.map((task) => TaskModel.fromMap(task)).toList();
      todoTasks = tasks.where((e) => e.isDone == false).toList();
      completedTasks = tasks.where((e) => e.isDone == true).toList();
      highPriorityTasks = tasks.where((e) => e.isHighPriority == true).toList();
      highPriorityTasks = highPriorityTasks.reversed.toList();

      // calculateProgress();
    }
    isLoading = false;
    notifyListeners();
  }

  // void _calculateProgress() {
  //   totalTasks = tasks.length;
  //   doneTasks = tasks.where((e) => e.isDone).length;
  //   percent = totalTasks == 0 ? 0 : (doneTasks / totalTasks);
  // }

  void doneTask(bool? value, int? index) async {
    if (index == null) return;

    todoTasks[index].isDone = value ?? false;
    final newIndex = tasks.indexWhere((e) => e.id == todoTasks[index].id);
    tasks[newIndex] = todoTasks[index];

    final String encodedData = jsonEncode(
      tasks.map((task) => task.toMap()).toList(),
    );
    await PreferencesManager().setString(StorageKey.tasks, encodedData);
    // _calculateProgress();
    _loadTasks();
  }

  void doneCompletedTask(bool? value, int? index) async {
    if (index == null) return;

    completedTasks[index].isDone = value ?? false;
    final newIndex = tasks.indexWhere((e) => e.id == completedTasks[index].id);
    tasks[newIndex] = completedTasks[index];

    final String encodedData = jsonEncode(
      tasks.map((task) => task.toMap()).toList(),
    );
    await PreferencesManager().setString(StorageKey.tasks, encodedData);
    // _calculateProgress();
    _loadTasks();
  }

  void doneHighPriorityTask(bool? value, int? index) async {
    if (index == null) return;

    highPriorityTasks[index].isDone = value ?? false;
    final newIndex = tasks.indexWhere(
      (e) => e.id == highPriorityTasks[index].id,
    );
    tasks[newIndex] = highPriorityTasks[index];

    final String encodedData = jsonEncode(
      tasks.map((task) => task.toMap()).toList(),
    );
    await PreferencesManager().setString(StorageKey.tasks, encodedData);
    // _calculateProgress();
    _loadTasks();
  }

  Future<void> deleteTask(int id) async {
    tasks.removeWhere((task) => task.id == id);
    todoTasks.removeWhere((e) => e.id == id);
    completedTasks.removeWhere((e) => e.id == id);
    highPriorityTasks.removeWhere((e) => e.id == id);
    // _calculateProgress();

    final String updatedTasks = jsonEncode(
      tasks.map((task) => task.toMap()).toList(),
    );
    await PreferencesManager().setString('tasks', updatedTasks);
    _loadTasks();
  }

  // Future<void> doneTask(bool? val, int? index) async {
  //   tasks[index!].isDone = val ?? false;
  //   calculateProgress();

  //   final String encodedData = jsonEncode(
  //     tasks.map((task) => task.toMap()).toList(),
  //   );
  //   await PreferencesManager().setString(StorageKey.tasks, encodedData);

  //   notifyListeners();
  // }
}
