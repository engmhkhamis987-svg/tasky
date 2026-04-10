import 'package:flutter/material.dart';
import 'package:tasky/core/components/task_item_widget.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/models/task_model.dart';

class Slivertasklistwidget extends StatelessWidget {
  const Slivertasklistwidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.emptyString,
    required this.onDelete,
    required this.onEdit,
  });
  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final Function(int) onDelete;
  final Function onEdit;
  final String emptyString;

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? SliverToBoxAdapter(
            child: Center(
              child: Text(
                emptyString,
                style: TextStyle(
                  color: Color(0XFFFFFCFC),
                  fontSize: AppSizes.sp16,
                ),
              ),
            ),
          )
        : SliverPadding(
            padding: EdgeInsets.only(bottom: AppSizes.ph80),
            sliver: SliverList.separated(
              itemCount: tasks.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: AppSizes.ph8),
              itemBuilder: (context, index) {
                return TaskItemWidget(
                  model: tasks[index],
                  onChanged: (bool? value) => onTap(value, index),
                  onDelete: (int id) => onDelete(id),
                  onEdit: () => onEdit(),
                );
              },
            ),
          );
  }
}
