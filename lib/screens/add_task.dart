import 'package:flutter/material.dart';

class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF181818),
      appBar: AppBar(
        centerTitle: false,
        title: Text('New Task'),
        backgroundColor: Color(0XFF181818),
        iconTheme: IconThemeData(color: Color(0xffFFFCFC)),
        titleTextStyle: TextStyle(
          color: Color(0xffFFFCFC),
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Center(child: Text('Add Task Screen')),
    );
  }
}
