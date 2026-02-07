import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/screens/add_task_screen.dart';
import 'package:tasky/widgets/task_list_widget.dart';

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? '';
    });
  }

  Future<void> _loadTasks() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final finalTasks = prefs.getString('tasks');
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

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    child: SvgPicture.asset('assets/images/logo.svg'),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Evening ,$userName',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0XFFFFFCFC),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'One task at a time.One step closer.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0XFFC6C6C6),
                          fontWeight: FontWeight.w400,
                        ),
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
                style: TextStyle(
                  fontSize: 32,
                  color: Color(0XFFFFFCFC),
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: [
                  Text(
                    'almost done ! ',
                    style: TextStyle(
                      fontSize: 32,
                      color: Color(0XFFFFFCFC),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SvgPicture.asset('assets/images/waving_hand.svg'),
                ],
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0XFF282828),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Achieved Tasks',
                          style: TextStyle(
                            color: Color(0XFFFFFCFC),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '$doneTasks Out of $totalTasks Done',
                          style: TextStyle(
                            color: Color(0XFFC6C6C6),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Transform.rotate(
                          angle: -pi / 2,
                          child: SizedBox(
                            width: 52,
                            height: 52,
                            child: CircularProgressIndicator(
                              value: percent,
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
                          '${(percent * 100).toInt()} %',
                          style: TextStyle(
                            color: Color(0XFFFFFCFC),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
              Text(
                'My Tasks',
                style: TextStyle(color: Color(0XFFFFFCFC), fontSize: 20),
              ),
              SizedBox(height: 16),
              Expanded(
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : TaskListWidget(
                        tasks: tasks,
                        onTap: (val, index) async {
                          setState(() {
                            tasks[index!].isDone = val ?? false;
                            _calculateProgress();
                          });
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          final String encodedData = jsonEncode(
                            tasks.map((task) => task.toMap()).toList(),
                          );
                          await prefs.setString('tasks', encodedData);
                        },
                        emptyString: 'No Data',
                      ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: SizedBox(
        height: 44,
        child: FloatingActionButton.extended(
          backgroundColor: Color(0XFF15B86C),
          foregroundColor: Color(0xffFFFCFC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
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
