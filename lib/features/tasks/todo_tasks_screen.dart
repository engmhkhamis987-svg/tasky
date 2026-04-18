import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/components/task_list_widget.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/features/tasks/tasks_controller.dart';

class TodoTasksScreen extends StatelessWidget {
  const TodoTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(AppSizes.pw18),
          child: Text(
            'To Do Tasks',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        Expanded(
          child: Consumer<TasksController>(
            builder: (context, controller, child) {
              return controller.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: EdgeInsets.all(AppSizes.pw16),
                      child: TaskListWidget(
                        tasks: controller.todoTasks,
                        onTap: (bool? value, int? index) async {
                          controller.doneTask(
                            value,
                            controller.todoTasks[index!].id,
                          );
                        },
                        onDelete: (id) {
                          controller.deleteTask(id);
                        },
                        onEdit: () => controller.init(),
                        emptyString: 'No tasks available',
                      ),
                    );
            },
          ),
        ),
      ],
    );
  }
}
