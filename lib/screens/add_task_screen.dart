import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/models/task_model.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescController = TextEditingController();
  bool isHighPriority = true;

  @override
  void dispose() {
    super.dispose();
    taskNameController.dispose();
    taskDescController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Task Name',
                  style: TextStyle(
                    color: Color(0xffFFFCFC),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: taskNameController,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0XFF282828),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Finish UI design for login screen',
                    hintStyle: TextStyle(color: Color(0XFF6D6D6D)),
                  ),
                  style: TextStyle(color: Color(0XFFFFFCFC)),
                  validator: (value) {
                    if (value!.trim() == "" || value.trim().isEmpty) {
                      return 'Please enter task name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Task Description',
                  style: TextStyle(
                    color: Color(0xffFFFCFC),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  maxLines: 5,
                  controller: taskDescController,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0XFF282828),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    hintText:
                        'Finish onboarding UI and hand off to devs by Thursday.',
                    hintStyle: TextStyle(color: Color(0XFF6D6D6D)),
                  ),
                  style: TextStyle(color: Color(0XFFFFFCFC)),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'High Priority  ',
                      style: TextStyle(
                        color: Color(0XFFFFFCFC),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Switch(
                      value: isHighPriority,
                      onChanged: (value) {
                        setState(() {
                          isHighPriority = value;
                        });
                      },
                      activeThumbColor: Color(0XFFFFFCFC),
                      activeTrackColor: Color(0XFF15B86C),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: ElevatedButton.icon(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              List taskList = [];
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              final tasks = prefs.getString("tasks");

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
              await prefs.setString("tasks", updatedTasks);

              Navigator.of(context).pop(true);
            }
          },
          label: Text("Add Task"),
          icon: Icon(Icons.add),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0XFF15B86C),
            foregroundColor: Color(0xffFFFCFC),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            fixedSize: Size(MediaQuery.of(context).size.width, 44),
          ),
        ),
      ),
    );
  }
}
