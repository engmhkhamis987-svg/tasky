import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/features/add_tasks/add_task_screen.dart';
import 'package:tasky/features/home/components/achieved%20Tasks_widget.dart';
import 'package:tasky/features/home/components/high_priority_tasks_widget.dart';
import 'package:tasky/features/home/components/sliverTaskListWidget.dart';
import 'package:tasky/models/task_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userName;
  List<TaskModel> tasks = [];
  bool isLoading = false;
  String? userImagePath;
  int totalTasks = 0;
  int doneTasks = 0;
  double percent = 0;

  Future<void> _loadUserName() async {
    setState(() {
      userName = PreferencesManager().getString('userName') ?? '';
      userImagePath = PreferencesManager().getString('user_image');
    });
  }

  Future<void> _loadTasks() async {
    setState(() {
      isLoading = true;
    });
    final finalTasks = PreferencesManager().getString('tasks');
    if (finalTasks != null) {
      final List<dynamic> tasksAfterDecode = jsonDecode(finalTasks);

      setState(() {
        tasks = tasksAfterDecode
            .map((task) => TaskModel.fromMap(task))
            .toList();

        _calculateProgress();
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  void _calculateProgress() {
    totalTasks = tasks.length;
    doneTasks = tasks.where((e) => e.isDone).length;
    percent = totalTasks == 0 ? 0 : (doneTasks / totalTasks);
  }

  Future<void> _doneTask(bool? val, int? index) async {
    setState(() {
      tasks[index!].isDone = val ?? false;
      _calculateProgress();
    });
    final String encodedData = jsonEncode(
      tasks.map((task) => task.toMap()).toList(),
    );
    await PreferencesManager().setString('tasks', encodedData);
  }

  Future<void> _deleteTask(int id) async {
    setState(() {
      tasks.removeWhere((task) => task.id == id);

      _calculateProgress();
    });
    final String updatedTasks = jsonEncode(
      tasks.map((task) => task.toMap()).toList(),
    );
    await PreferencesManager().setString('tasks', updatedTasks);
  }

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      CircleAvatar(
                        radius: AppSizes.r32,
                        backgroundImage: userImagePath == null
                            ? AssetImage('assets/images/person.png')
                            : FileImage(File(userImagePath!)),
                        backgroundColor: Colors.transparent,
                      ),
                      SizedBox(width: AppSizes.w8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good Evening ,$userName',
                            style: Theme.of(context).textTheme.titleMedium,
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
                        icon: Icon(Icons.sunny, color: Colors.white, size: 30),
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

                  AchievedTasksWidget(
                    doneTasks: doneTasks,
                    totalTasks: totalTasks,
                    percent: percent,
                  ),
                  SizedBox(height: AppSizes.ph16),
                  HighPriorityTasksWidget(
                    tasks: tasks,
                    onTap: (val, index) {
                      _doneTask(val, index);
                    },
                    refresh: _loadTasks,
                  ),

                  SizedBox(height: AppSizes.ph20),
                  Text(
                    'My Tasks',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  SizedBox(height: AppSizes.ph16),
                ],
              ),
            ),

            isLoading
                ? SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  )
                : Slivertasklistwidget(
                    tasks: tasks,
                    onTap: (bool? val, int? index) {
                      _doneTask(val, index);
                    },
                    onDelete: (int id) {
                      _deleteTask(id);
                    },
                    onEdit: () => _loadTasks(),

                    emptyString: 'No Data',
                  ),
          ],
        ),
      ),

      floatingActionButton: SizedBox(
        height: AppSizes.h44,
        child: FloatingActionButton.extended(
          onPressed: () async {
            final bool result = await Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => AddTaskScreen()));
            if (result) {
              _loadTasks();
            }
          },
          label: Text('Add New Task'),
          icon: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
