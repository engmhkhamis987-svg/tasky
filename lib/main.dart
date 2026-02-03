import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/screens/home_screen.dart';
import 'package:tasky/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = await SharedPreferences.getInstance();
  final savedName = pref.getString('userName');
  runApp(MyApp(userName: savedName));
  //mmmmmmmmmmmmmmm
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.userName});
  final String? userName;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasky App',
      home: userName == null ? WelcomeScreen() : HomeScreen(),
    );
  }
}
