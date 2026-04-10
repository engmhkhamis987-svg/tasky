import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/components/task_list_widget.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/models/task_model.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<TaskModel> todoTasks = [];
  bool isLoading = false;

  Future<void> _loadTasks() async {
    setState(() {
      isLoading = true;
    });

    final finalTasks = PreferencesManager().getString('tasks');

    if (finalTasks != null) {
      final List<dynamic> tasksAfterDecode = jsonDecode(finalTasks);
      setState(() {
        todoTasks = tasksAfterDecode
            .map((task) => TaskModel.fromMap(task))
            .toList()
            .where((e) => e.isDone == false)
            .toList();
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _deleteTask(int id) async {
    List<TaskModel> tasks = [];
    final finalTasks = PreferencesManager().getString('tasks');
    if (finalTasks != null) {
      final List<dynamic> allTasks = jsonDecode(finalTasks);

      tasks = allTasks.map((task) => TaskModel.fromMap(task)).toList();

      tasks.removeWhere((task) => task.id == id);
      setState(() {
        todoTasks.removeWhere((e) => e.id == id);
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(AppSizes.pw18),
          child: Text(
            'To Do Tasks',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        Expanded(
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsets.all(AppSizes.pw16),
                  child: TaskListWidget(
                    tasks: todoTasks,
                    onTap: (bool? value, int? index) async {
                      setState(() {
                        todoTasks[index!].isDone = value ?? false;
                      });

                      final allData = PreferencesManager().getString('tasks');
                      if (allData != null) {
                        final List<TaskModel> allDataList =
                            (jsonDecode(allData) as List)
                                .map((e) => TaskModel.fromMap(e))
                                .toList();

                        final newIndex = allDataList.indexWhere(
                          (e) => e.id == todoTasks[index!].id,
                        );
                        allDataList[newIndex] = todoTasks[index!];

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
                    onDelete: (id) {
                      _deleteTask(id);
                    },
                    onEdit: () => _loadTasks(),
                    emptyString: 'No tasks available',
                  ),
                ),
        ),
      ],
    );
  }
}
