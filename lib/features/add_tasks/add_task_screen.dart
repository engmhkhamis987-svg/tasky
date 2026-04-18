import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';
import 'package:tasky/features/add_tasks/add_task_controller.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddTaskController>(
      create: (context) => AddTaskController(),
      builder: (context, child) {
        final controller = context.read<AddTaskController>();
        // Provider.of<AddTaskController>(context, listen: false);
        return Scaffold(
          appBar: AppBar(title: Text('New Task')),
          body: Padding(
            padding: EdgeInsets.all(AppSizes.pw16),
            child: Form(
              key: controller.formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormField(
                      controller: controller.taskNameController,
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
                      controller: controller.taskDescController,
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
                        Consumer<AddTaskController>(
                          builder: (context, controller, child) {
                            return Switch(
                              value: controller.isHighPriority,
                              onChanged: (value) {
                                controller.toggleIsHighPriority(value);
                              },
                              activeThumbColor: Color(0XFFFFFCFC),
                              activeTrackColor: Color(0XFF15B86C),
                            );
                          },
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
                controller.addTask(context);
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
      },
    );
  }
}
