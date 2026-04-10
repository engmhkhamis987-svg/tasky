import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/components/task_list_widget.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/models/task_model.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  List<TaskModel> completedTasks = [];
  bool isLoading = false;

  Future<void> _loadTasks() async {
    setState(() {
      isLoading = true;
    });

    final finalTasks = PreferencesManager().getString('tasks');

    if (finalTasks != null) {
      final List<dynamic> tasksAfterDecode = jsonDecode(finalTasks);
      setState(() {
        completedTasks = tasksAfterDecode
            .map((task) => TaskModel.fromMap(task))
            .toList()
            .where((e) => e.isDone == true)
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
        completedTasks.removeWhere((e) => e.id == id);
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
            'Completed Tasks',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),

        Expanded(
          child: Padding(
            padding: EdgeInsets.all(AppSizes.pw16),
            child: TaskListWidget(
              tasks: completedTasks,
              onTap: (bool? value, int? index) async {
                setState(() {
                  completedTasks[index!].isDone = value ?? true;
                });
                final allData = PreferencesManager().getString('tasks');

                if (allData != null) {
                  final List<TaskModel> allDataList =
                      (jsonDecode(allData) as List)
                          .map((e) => TaskModel.fromMap(e))
                          .toList();

                  final newIndex = allDataList.indexWhere(
                    (e) => e.id == completedTasks[index!].id,
                  );
                  allDataList[newIndex] = completedTasks[index!];

                  final String encodedData = jsonEncode(
                    allDataList.map((task) => task.toMap()).toList(),
                  );

                  await PreferencesManager().setString('tasks', encodedData);

                  _loadTasks();
                }
              },
              onDelete: (id) => _deleteTask(id),
              onEdit: () => _loadTasks(),
              emptyString: 'No tasks Completed',
            ),
          ),
        ),
      ],
    );
  }
}
