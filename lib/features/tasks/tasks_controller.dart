import 'package:flutter/material.dart';
import 'package:tasky/core/services/hive_storage_manager.dart';
import 'package:tasky/models/task_model.dart';

class TasksController with ChangeNotifier {
  bool isLoading = false;

  List<TaskModel> tasks = [];
  List<TaskModel> todoTasks = [];
  List<TaskModel> completedTasks = [];
  List<TaskModel> highPriorityTasks = [];

  int totalTasks = 0;
  int doneTasks = 0;
  double percent = 0;

  void init() {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    isLoading = true;
    notifyListeners();

    tasks = HiveStorageManager().loadTasks();
    _loadData();
    _calculateProgress();

    isLoading = false;
    notifyListeners();
  }

  void _loadData() {
    todoTasks = tasks.where((e) => e.isDone == false).toList();
    completedTasks = tasks.where((e) => e.isDone == true).toList();
    highPriorityTasks = tasks.where((e) => e.isHighPriority == true).toList();
    highPriorityTasks = highPriorityTasks.reversed.toList();
  }

  void _calculateProgress() {
    totalTasks = tasks.length;
    doneTasks = tasks.where((e) => e.isDone).length;
    percent = totalTasks == 0 ? 0 : (doneTasks / totalTasks);
  }

  Future<void> doneTask(bool? val, int id) async {
    final index = tasks.indexWhere((e) => e.id == id);

    tasks[index].isDone = val ?? false;
    _loadData();
    _calculateProgress();
    await HiveStorageManager().saveTasks(tasks);

    notifyListeners();
  }

  Future<void> deleteTask(int id) async {
    tasks.removeWhere((task) => task.id == id);

    _loadData();
    _calculateProgress();

    await HiveStorageManager().saveTasks(tasks);

    notifyListeners();
  }
}
