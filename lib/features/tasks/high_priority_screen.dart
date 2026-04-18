import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/components/task_list_widget.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/features/tasks/tasks_controller.dart';

class HighPriorityScreen extends StatelessWidget {
  const HighPriorityScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = context.read<TasksController>();
    return Scaffold(
      appBar: AppBar(title: const Text('High Priority Tasks')),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.pw18),
        child: controller.isLoading
            ? CircularProgressIndicator()
            : Padding(
                padding: EdgeInsets.all(AppSizes.pw16),
                child: Consumer<TasksController>(
                  builder: (context, valueController, child) => TaskListWidget(
                    tasks: valueController.highPriorityTasks,
                    onTap: (bool? value, int? index) async {
                      controller.doneTask(
                        value,
                        valueController.highPriorityTasks[index!].id,
                      );
                    },
                    onDelete: (id) => controller.deleteTask(id),
                    onEdit: () => controller.init(),
                    emptyString: 'No tasks available',
                  ),
                ),
              ),
      ),
    );
  }
}
