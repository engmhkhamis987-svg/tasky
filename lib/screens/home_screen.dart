import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/screens/add_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userName;
  List<TaskModel> tasks = [];

  Future<void> _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? '';
    });
  }

  Future<void> _loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final finalTasks = prefs.getString('tasks');
    if (finalTasks == null) return;
    final List<dynamic> tasksAfterDecode = jsonDecode(finalTasks);
    setState(() {
      tasks = tasksAfterDecode.map((task) => TaskModel.fromMap(task)).toList();
    });
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
      backgroundColor: Color(0XFF181818),
      floatingActionButton: SizedBox(
        height: 44,
        child: FloatingActionButton.extended(
          backgroundColor: Color(0XFF15B86C),
          foregroundColor: Color(0xffFFFCFC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => AddTask()));
          },
          label: Text('Add New Task'),
          icon: Icon(Icons.add, color: Colors.white),
        ),
      ),
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
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(top: 8),
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 54,
                      decoration: BoxDecoration(
                        color: Color(0XFF282828),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            value: tasks[index].isDone,
                            onChanged: (val) async {
                              setState(() {
                                tasks[index].isDone = val ?? false;
                              });
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              final updatedTask = tasks
                                  .map((task) => task.toMap())
                                  .toList();
                              final encodedTasks = jsonEncode(updatedTask);
                              prefs.setString('tasks', encodedTasks);
                            },
                            activeColor: Color(0XFF15B86C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tasks[index].taskName,
                                style: TextStyle(
                                  color: tasks[index].isDone
                                      ? Color(0XFFA0A0A0)
                                      : Color(0XFFFFFCFC),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  decoration: tasks[index].isDone
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  decorationColor: Color(0XFFA0A0A0),
                                ),
                              ),
                              Text(
                                tasks[index].taskDescription,
                                style: TextStyle(
                                  color: Color(0XFFC6C6C6),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
