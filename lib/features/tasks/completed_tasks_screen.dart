import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/components/task_list_widget.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/features/tasks/tasks_controller.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({super.key});

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
            child: Consumer<TasksController>(
              builder: (context, controller, child) => TaskListWidget(
                tasks: controller.completedTasks,
                onTap: (bool? value, int? index) async {
                  controller.doneTask(
                    value,
                    controller.completedTasks[index!].id,
                  );
                },
                onDelete: (id) => controller.deleteTask(id),
                onEdit: () => controller.init(),
                emptyString: 'No tasks Completed',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
