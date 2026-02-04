import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/screens/main_screen.dart';
import 'package:tasky/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = await SharedPreferences.getInstance();
  final savedName = pref.getString('userName');
  runApp(MyApp(userName: savedName));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.userName});
  final String? userName;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0XFF181818),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0XFF181818),
          titleTextStyle: TextStyle(
            color: Color(0XFFFFFCFC),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          centerTitle: false,
          iconTheme: IconThemeData(color: Color(0xffFFFCFC)),
        ),
      ),
      title: 'Tasky App',
      home: userName == null ? WelcomeScreen() : MainScreen(),
    );
  }
}
