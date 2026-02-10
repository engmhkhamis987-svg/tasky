import 'package:flutter/material.dart';
import 'package:tasky/core/widgets/custom_checkbox.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/widgets/task_item_widget.dart';

class Slivertasklistwidget extends StatelessWidget {
  const Slivertasklistwidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.emptyString,
  });
  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final String emptyString;

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? SliverToBoxAdapter(
            child: Center(
              child: Text(
                emptyString,
                style: TextStyle(color: Color(0XFFFFFCFC), fontSize: 16),
              ),
            ),
          )
        : SliverPadding(
            padding: EdgeInsets.only(bottom: 80),
            sliver: SliverList.separated(
              itemCount: tasks.length,
              separatorBuilder: (context, index) => SizedBox(height: 8),
              itemBuilder: (context, index) {
                return TaskItemWidget(
                  model: tasks[index],
                  onChanged: (bool? value) => onTap(value, index),
                );
              },
            ),
          );
  }
}
