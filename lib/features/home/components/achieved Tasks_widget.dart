import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/features/home/home_controller.dart';
import 'package:tasky/features/tasks/tasks_controller.dart';

class AchievedTasksWidget extends StatelessWidget {
  const AchievedTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksController>(
      builder: (BuildContext context, TasksController controller, Widget? child) {
        return Container(
          padding: EdgeInsets.all(AppSizes.w16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(AppSizes.r20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Achieved Tasks',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: AppSizes.h4),
                  Text(
                    '${controller.doneTasks} Out of ${controller.totalTasks} Done',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Transform.rotate(
                    angle: -pi / 2,
                    child: SizedBox(
                      width: AppSizes.w48,
                      height: AppSizes.w48,
                      child: CircularProgressIndicator(
                        value: controller.percent,
                        // color: Color(0XFF15B86C),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0XFF15B86C),
                        ),
                        backgroundColor: Color(0XFF6D6D6D),
                        strokeWidth: 4,
                      ),
                    ),
                  ),
                  Text(
                    '${(controller.percent * 100).toInt()} %',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(fontSize: AppSizes.sp14),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
