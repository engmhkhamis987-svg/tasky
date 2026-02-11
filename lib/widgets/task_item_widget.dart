import 'package:flutter/material.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/core/widgets/custom_checkbox.dart';
import 'package:tasky/models/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.model,
    required this.onChanged,
  });
  final TaskModel model;
  final void Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ThemeController.isDark()
              ? Colors.transparent
              : Color(0XFFD1DAD6),
        ),
      ),

      child: Row(
        children: [
          SizedBox(height: 8),
          CustomCheckbox(
            value: model.isDone,
            onChanged: (val) => onChanged(val),
          ),
          SizedBox(height: 16),

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
                    style: TextStyle(color: Color(0XFFC6C6C6), fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              print(value);
            },
            icon: Icon(
              Icons.more_vert,
              color: ThemeController.isDark()
                  ? (model.isDone ? Color(0XFFA0A0A0) : Color(0XFFC6C6C6))
                  : (model.isDone ? Color(0XFF3A4640) : Color(0XFF6A6A6A)),
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem(value: 'Edit', child: Text("Edit")),
                PopupMenuItem(value: 'Delete', child: Text("Delete")),
              ];
            },
          ),
        ],
      ),
    );
  }
}
