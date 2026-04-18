import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/components/task_item_widget.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/features/home/home_controller.dart';
import 'package:tasky/models/task_model.dart';

class Slivertasklistwidget extends StatelessWidget {
  const Slivertasklistwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder:
          (BuildContext context, HomeController controller, Widget? child) {
            final List<TaskModel> tasksList = controller.tasks;
            return controller.isLoading
                ? SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  )
                : tasksList.isEmpty
                ? SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        'No Data',
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
                      itemCount: tasksList.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: AppSizes.ph8),
                      itemBuilder: (context, index) {
                        return TaskItemWidget(
                          model: tasksList[index],
                          onChanged: (bool? value) =>
                              controller.doneTask(value, index),
                          onDelete: (int id) => controller.deleteTask(id),
                          onEdit: () => controller.init(),
                        );
                      },
                    ),
                  );
          },
    );
  }
}
