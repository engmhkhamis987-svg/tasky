import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/widgets/task_item_widget.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.emptyString,
    required this.onDelete,
    required this.onEdit,
  });
  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final String emptyString;
  final Function(int) onDelete;
  final Function onEdit;

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? Center(
            child: Text(
              emptyString,
              style: Theme.of(context).textTheme.labelLarge,

              //  TextStyle(color: Color(0XFFFFFCFC), fontSize: 16),
            ),
          )
        : ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: 50),
            itemCount: tasks.length,
            separatorBuilder: (context, index) => SizedBox(height: 8),
            itemBuilder: (context, index) {
              return TaskItemWidget(
                model: tasks[index],
                onChanged: (bool? value) => onTap(value, index),
                onDelete: (int id) {
                  onDelete(id);
                },
                onEdit: () {
                  onEdit();
                },
              );
            },
          );
  }
}
