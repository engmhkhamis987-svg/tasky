import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/components/task_list_widget.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/models/task_model.dart';

class HighPriorityScreen extends StatefulWidget {
  const HighPriorityScreen({super.key});

  @override
  State<HighPriorityScreen> createState() => _HighPriorityScreenState();
}

class _HighPriorityScreenState extends State<HighPriorityScreen> {
  List<TaskModel> highPriorityTasks = [];
  bool isLoading = false;

  Future<void> _loadTasks() async {
    setState(() {
      isLoading = true;
    });
    final finalTasks = PreferencesManager().getString('tasks');

    if (finalTasks != null) {
      final List<dynamic> tasksAfterDecode = jsonDecode(finalTasks);
      setState(() {
        highPriorityTasks = tasksAfterDecode
            .map((task) => TaskModel.fromMap(task))
            .toList()
            .where((e) => e.isHighPriority)
            .toList()
            .reversed
            .toList();
      });

      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _deleteTask(int id) async {
    List<TaskModel> tasks = [];
    final finalTasks = PreferencesManager().getString('tasks');
    if (finalTasks != null) {
      final List<dynamic> allTasks = jsonDecode(finalTasks);

      tasks = allTasks.map((task) => TaskModel.fromMap(task)).toList();

      tasks.removeWhere((task) => task.id == id);

      setState(() {
        highPriorityTasks.removeWhere((e) => e.id == id);
      });

      final String updatedTasks = jsonEncode(
        tasks.map((task) => task.toMap()).toList(),
      );
      await PreferencesManager().setString('tasks', updatedTasks);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('High Priority Tasks')),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.pw18),
        child: isLoading
            ? CircularProgressIndicator()
            : Padding(
                padding: EdgeInsets.all(AppSizes.pw16),
                child: TaskListWidget(
                  tasks: highPriorityTasks,
                  onTap: (bool? value, int? index) async {
                    setState(() {
                      highPriorityTasks[index!].isDone = value ?? false;
                    });

                    final allData = PreferencesManager().getString('tasks');

                    if (allData != null) {
                      final List<TaskModel> allDataList =
                          (jsonDecode(allData) as List)
                              .map((e) => TaskModel.fromMap(e))
                              .toList();

                      final newIndex = allDataList.indexWhere(
                        (e) => e.id == highPriorityTasks[index!].id,
                      );
                      allDataList[newIndex] = highPriorityTasks[index!];

                      final String encodedData = jsonEncode(
                        allDataList.map((task) => task.toMap()).toList(),
                      );

                      await PreferencesManager().setString(
                        'tasks',
                        encodedData,
                      );

                      _loadTasks();
                    }
                  },
                  onDelete: (id) => _deleteTask(id),
                  onEdit: () => _loadTasks(),
                  emptyString: 'No tasks available',
                ),
              ),
      ),
    );
  }
}
