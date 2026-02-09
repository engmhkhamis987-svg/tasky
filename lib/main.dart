import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/theme/dark_theme.dart';
import 'package:tasky/core/theme/light_theme.dart';
import 'package:tasky/screens/main_screen.dart';
import 'package:tasky/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PreferencesManager().init();
  final savedName = PreferencesManager().getString('userName');

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
      theme: lightTheme,
      title: 'Tasky App',
      home: userName != null ? WelcomeScreen() : MainScreen(),
    );
  }
}
