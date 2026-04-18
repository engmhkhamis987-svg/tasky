import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/features/add_tasks/add_task_screen.dart';
import 'package:tasky/features/home/components/achieved%20Tasks_widget.dart';
import 'package:tasky/features/home/components/high_priority_tasks_widget.dart';
import 'package:tasky/features/home/components/sliverTaskListWidget.dart';
import 'package:tasky/features/home/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (BuildContext context) => HomeController()..init(),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(AppSizes.w16),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Selector<HomeController, String?>(
                          selector: (context, HomeController controller) =>
                              controller.userImagePath,
                          builder: (context, userImagePath, child) =>
                              CircleAvatar(
                                radius: AppSizes.r32,
                                backgroundImage: userImagePath == null
                                    ? AssetImage('assets/images/person.png')
                                    : FileImage(File(userImagePath)),
                                backgroundColor: Colors.transparent,
                              ),
                        ),
                        SizedBox(width: AppSizes.w8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Selector<HomeController, String?>(
                              selector: (context, HomeController controller) =>
                                  controller.userName,
                              builder: (context, userName, child) => Text(
                                'Good Evening ,$userName',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            Text(
                              'One task at a time.One step closer.',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.sunny,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSizes.h16),
                    Text(
                      'Yuhuu ,Your work Is',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Row(
                      children: [
                        Text(
                          'almost done ! ',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        CustomSvgPicture.withoutColorFilter(
                          path: 'assets/images/waving_hand.svg',
                        ),
                      ],
                    ),
                    SizedBox(height: AppSizes.ph16),

                    AchievedTasksWidget(),
                    SizedBox(height: AppSizes.ph16),
                    HighPriorityTasksWidget(),

                    SizedBox(height: AppSizes.ph20),
                    Text(
                      'My Tasks',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    SizedBox(height: AppSizes.ph16),
                  ],
                ),
              ),

              Slivertasklistwidget(),
            ],
          ),
        ),

        floatingActionButton: SizedBox(
          height: AppSizes.h44,
          child: Builder(
            builder: (contextController) {
              return FloatingActionButton.extended(
                onPressed: () async {
                  final bool result = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddTaskScreen()),
                  );
                  if (result) {
                    contextController.read<HomeController>().loadTasks();
                    // controller.loadTasks();
                  }
                },
                label: Text('Add New Task'),
                icon: Icon(Icons.add, color: Colors.white),
              );
            },
          ),
        ),
      ),
    );
  }
}
