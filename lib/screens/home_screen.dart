import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/screens/add_task_screen.dart';
import 'package:tasky/widgets/achieved%20Tasks_widget.dart';
import 'package:tasky/widgets/high_priority_tasks_widget.dart';
import 'package:tasky/widgets/sliverTaskListWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userName;
  List<TaskModel> tasks = [];
  bool isLoading = false;
  int totalTasks = 0;
  int doneTasks = 0;
  double percent = 0;

  Future<void> _loadUserName() async {
    setState(() {
      userName = PreferencesManager().getString('userName') ?? '';
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
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        child: CustomSvgPicture.withoutColorFilter(
                          path: 'assets/images/logo.svg',
                        ),
                      ),
                      SizedBox(width: 16),
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
                  SizedBox(height: 16),
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
                  SizedBox(height: 16),

                  AchievedTasksWidget(
                    doneTasks: doneTasks,
                    totalTasks: totalTasks,
                    percent: percent,
                  ),
                  SizedBox(height: 16),
                  HighPriorityTasksWidget(
                    tasks: tasks,
                    onTap: (val, index) {
                      _doneTask(val, index);
                    },
                    refresh: _loadTasks,
                  ),

                  SizedBox(height: 20),
                  Text(
                    'My Tasks',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  SizedBox(height: 16),
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

                    emptyString: 'No Data',
                  ),
          ],
        ),
      ),

      floatingActionButton: SizedBox(
        height: 44,
        child: FloatingActionButton.extended(
          onPressed: () async {
            final bool result = await Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => AddTaskScreen()));
            if (result && result != null) {
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
