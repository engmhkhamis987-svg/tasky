import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/features/home/home_screen.dart';
import 'package:tasky/features/profile/profile_screen.dart';
import 'package:tasky/features/tasks/completed_tasks_screen.dart';
import 'package:tasky/features/tasks/tasks_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> screens = [
    HomeScreen(), // Placeholder for Home Screen
    TasksScreen(), // Placeholder for Tasks Screen
    CompletedTasksScreen(), // Placeholder for Completed Tasks Screen
    ProfileScreen(), // Placeholder for Profile Screen
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: screens[selectedIndex]),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: customSvg('assets/images/home.svg', 0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: customSvg('assets/images/todo.svg', 1),
            label: 'To Do',
          ),
          BottomNavigationBarItem(
            icon: customSvg('assets/images/completed.svg', 2),

            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: customSvg('assets/images/profile.svg', 3),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  SvgPicture customSvg(String path, int index) {
    return SvgPicture.asset(
      path,
      colorFilter: ColorFilter.mode(
        selectedIndex == index ? Color(0XFF15B86C) : Color(0XFFC6C6C6),
        BlendMode.srcIn,
      ),
    );
  }
}
