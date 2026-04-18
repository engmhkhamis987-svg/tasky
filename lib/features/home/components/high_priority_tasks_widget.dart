import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/core/widgets/custom_checkbox.dart';
import 'package:tasky/features/home/home_controller.dart';
import 'package:tasky/features/tasks/high_priority_screen.dart';

class HighPriorityTasksWidget extends StatelessWidget {
  const HighPriorityTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, HomeController controller, child) {
        final tasksList = controller.tasks;
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(AppSizes.r20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(AppSizes.pw16),
                      child: Text(
                        'High Priority Tasks',
                        style: TextStyle(
                          color: Color(0XFF15B86C),
                          fontSize: AppSizes.sp14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    ...tasksList.reversed
                        .where((e) => e.isHighPriority)
                        .toList()
                        .take(4)
                        .map((e) {
                          return Row(
                            children: [
                              CustomCheckbox(
                                value: e.isDone,
                                onChanged: (val) {
                                  final index = tasksList.indexWhere(
                                    (ele) => ele.id == e.id,
                                  );
                                  controller.doneTask(val, index);
                                },
                              ),

                              SizedBox(width: AppSizes.pw8),
                              Expanded(
                                child: Text(
                                  e.taskName,
                                  style: e.isDone
                                      ? Theme.of(context).textTheme.titleLarge
                                      : Theme.of(context).textTheme.titleMedium,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          );
                        }),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HighPriorityScreen(),
                    ),
                  );
                  controller.init();
                },
                child: Padding(
                  padding: EdgeInsets.all(AppSizes.pw16),
                  child: Container(
                    padding: EdgeInsets.all(AppSizes.pw8),
                    height: AppSizes.h56,
                    width: AppSizes.w48,

                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      border: Border.all(
                        color: ThemeController.isDark()
                            ? Color(0XFF6E6E6E)
                            : Color(0XFFD1DAD6),
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      'assets/images/arrow_up_icon.svg',
                      width: AppSizes.w24,
                      height: AppSizes.h24,
                      colorFilter: ColorFilter.mode(
                        ThemeController.isDark()
                            ? Color(0XFFC6C6C6)
                            : Color(0XFF3A4640),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
