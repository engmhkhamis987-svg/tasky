import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/widgets/task_list_widget.dart';

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final finalTasks = prefs.getString('tasks');

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

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Completed Tasks'),
        iconTheme: IconThemeData(color: Color(0xffFFFCFC)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TaskListWidget(
          tasks: completedTasks,
          onTap: (bool? value, int? index) async {
            setState(() {
              completedTasks[index!].isDone = value ?? true;
            });
            SharedPreferences prefs = await SharedPreferences.getInstance();
            final allData = prefs.getString('tasks');
            if (allData != null) {
              final List<TaskModel> allDataList = (jsonDecode(allData) as List)
                  .map((e) => TaskModel.fromMap(e))
                  .toList();

              final newIndex = allDataList.indexWhere(
                (e) => e.id == completedTasks[index!].id,
              );
              allDataList[newIndex] = completedTasks[index!];

              final String encodedData = jsonEncode(
                allDataList.map((task) => task.toMap()).toList(),
              );
              await prefs.setString('tasks', encodedData);
              _loadTasks();
            }
          },
          emptyString: 'No tasks Completed',
        ),
      ),
    );
  }
}
