import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/enums/task_item_actions_enum.dart';
import 'package:tasky/core/services/file_storage_manager.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/core/widgets/custom_checkbox.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';
import 'package:tasky/models/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.model,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit,
  });
  final TaskModel model;
  final void Function(bool?) onChanged;
  final Function(int) onDelete;
  final Function onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: AppSizes.h80,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppSizes.r16),
        border: Border.all(
          color: ThemeController.isDark()
              ? Colors.transparent
              : Color(0XFFD1DAD6),
        ),
      ),

      child: Row(
        children: [
          SizedBox(height: AppSizes.ph8),
          CustomCheckbox(
            value: model.isDone,
            onChanged: (val) => onChanged(val),
          ),
          SizedBox(height: AppSizes.ph16),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.taskName,
                  style: model.isDone
                      ? Theme.of(context).textTheme.titleLarge
                      : Theme.of(context).textTheme.titleMedium,

                  maxLines: 1,
                ),
                if (model.taskDescription.isNotEmpty)
                  Text(
                    model.taskDescription,
                    style: TextStyle(
                      color: Color(0XFFC6C6C6),
                      fontSize: AppSizes.sp14,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
              ],
            ),
          ),
          PopupMenuButton<TaskItemActionsEnum>(
            onSelected: (value) async {
              switch (value) {
                case TaskItemActionsEnum.markAsDone:
                  onChanged(!model.isDone);
                case TaskItemActionsEnum.delete:
                  await _showAlertDialog(context);
                case TaskItemActionsEnum.edit:
                  final result = await _showButtonSheet(context, model);
                  if (result != null && result) {
                    onEdit();
                  }
              }
            },
            icon: Icon(
              Icons.more_vert,
              color: ThemeController.isDark()
                  ? (model.isDone ? Color(0XFFA0A0A0) : Color(0XFFC6C6C6))
                  : (model.isDone ? Color(0XFF6A6A6A) : Color(0XFF3A4640)),
            ),
            itemBuilder: (context) {
              return TaskItemActionsEnum.values.map((e) {
                return PopupMenuItem(value: e, child: Text(e.name));
              }).toList();
            },
          ),
        ],
      ),
    );
  }

  _showAlertDialog(context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete Task"),
          content: Text("Are you sure you want to delete task"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onDelete(model.id);
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showButtonSheet(BuildContext context, TaskModel model) {
    TextEditingController taskNameController = TextEditingController(
      text: model.taskName,
    );
    TextEditingController taskDescController = TextEditingController(
      text: model.taskDescription,
    );
    GlobalKey<FormState> formKey = GlobalKey();
    bool isHighPriority = model.isHighPriority;
    return showModalBottomSheet<bool?>(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => Padding(
            padding: EdgeInsets.all(AppSizes.pw16),
            child: Form(
              key: formKey,
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
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: AppSizes.ph20,
                      right: AppSizes.pw16,
                      left: AppSizes.pw16,
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          List taskList = [];
                          final tasks = PreferencesManager().getString(
                            StorageKey.tasks,
                          );

                          if (tasks != null) {
                            taskList = jsonDecode(tasks);
                          }

                          // taskList = await FileStorageManager().loadTasks();
                          TaskModel newModel = TaskModel(
                            id: model.id,
                            taskName: taskNameController.text.trim(),
                            taskDescription: taskDescController.text.trim(),
                            isHighPriority: isHighPriority,
                            isDone: model.isDone,
                          );

                          final item = taskList.firstWhere(
                            (element) => element['id'] == model.id,
                          );

                          final int index = taskList.indexOf(item);

                          taskList[index] = newModel.toMap();

                          final updatedTasks = jsonEncode(taskList);

                          await PreferencesManager().setString(
                            StorageKey.tasks,
                            updatedTasks,
                          );

                          Navigator.of(context).pop(true);
                        }
                      },
                      label: Text("Edit Task"),
                      icon: Icon(Icons.edit),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSizes.r30),
                        ),
                        // fixedSize: Size(MediaQuery.of(context).size.width, 40),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
