import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';
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
        padding: EdgeInsets.all(AppSizes.pw16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  controller: taskNameController,
                  title: 'Task Name',
                  hintText: 'Design login screen',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter task name';
                    }
                    return null;
                  },
                ),

                SizedBox(height: AppSizes.ph20),

                CustomTextFormField(
                  controller: taskDescController,
                  title: 'Task Description',
                  hintText: 'Finish UI design for login screen',
                  maxLines: 5,
                ),

                SizedBox(height: AppSizes.ph20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'High Priority  ',
                      style: Theme.of(context).textTheme.titleMedium,
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
        padding: EdgeInsets.only(
          bottom: AppSizes.ph20,
          right: AppSizes.pw16,
          left: AppSizes.pw16,
        ),
        child: ElevatedButton.icon(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              List taskList = [];

              final tasks = PreferencesManager().getString("tasks");

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

              await PreferencesManager().setString("tasks", updatedTasks);

              Navigator.of(context).pop(true);
            }
          },
          label: Text("Add Task"),
          icon: Icon(Icons.add),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.r30),
            ),
            // fixedSize: Size(MediaQuery.of(context).size.width, 44),
          ),
        ),
      ),
    );
  }
}
