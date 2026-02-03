import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/screens/add_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userName;

  Future<void> _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF181818),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
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

              Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0XFF15B86C),
                    foregroundColor: Color(0xffFFFCFC),
                    fixedSize: Size(168, 40),
                  ),
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (context) => AddTask()));
                  },
                  label: Text('Add Task'),
                  icon: Icon(Icons.add),
                ),
              ),
              // Add your task list and other UI components here
            ],
          ),
        ),
      ),
    );
  }
}
