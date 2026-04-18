import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/models/task_model.dart';

class AddTaskController with ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescController = TextEditingController();
  bool isHighPriority = true;

  void addTask(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      List taskList = [];

      final tasks = PreferencesManager().getString(StorageKey.tasks);

      if (tasks != null) {
        taskList = jsonDecode(tasks);
      }
      TaskModel model = TaskModel(
        id: taskList.length + 1,
        taskName: taskNameController.text.trim(),
        taskDescription: taskDescController.text.trim(),
        isHighPriority: isHighPriority,
      );

      taskList.add(model.toMap());

      final updatedTasks = jsonEncode(taskList);

      await PreferencesManager().setString(StorageKey.tasks, updatedTasks);

      Navigator.of(context).pop(true);
    }
  }

  void toggleIsHighPriority(bool value) {
    isHighPriority = value;
    notifyListeners();
  }
}
