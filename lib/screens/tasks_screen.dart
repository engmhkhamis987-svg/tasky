import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/widgets/task_list_widget.dart';

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final finalTasks = prefs.getString('tasks');

    if (finalTasks != null) {
      final List<dynamic> tasksAfterDecode = jsonDecode(finalTasks);
      setState(() {
        todoTasks = tasksAfterDecode
            .map((task) => TaskModel.fromMap(task))
            .toList()
            .where((e) => e.isDone == false)
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            'To Do Tasks',
            style: TextStyle(
              color: Color(0xffFFFCFC),
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TaskListWidget(
              tasks: todoTasks,
              onTap: (bool? value, int? index) async {
                setState(() {
                  todoTasks[index!].isDone = value ?? false;
                });
                SharedPreferences prefs = await SharedPreferences.getInstance();
                final allData = prefs.getString('tasks');
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
                  await prefs.setString('tasks', encodedData);
                  _loadTasks();
                }
              },
              emptyString: 'No tasks available',
            ),
          ),
        ),
      ],
    );
  }
}
