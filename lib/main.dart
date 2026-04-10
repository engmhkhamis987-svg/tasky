import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/theme/dark_theme.dart';
import 'package:tasky/core/theme/light_theme.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/features/navigations/main_screen.dart';
import 'package:tasky/features/welcome/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  await PreferencesManager().init();
  ThemeController().init();
  final savedName = PreferencesManager().getString('userName');

  runApp(MyApp(userName: savedName));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.userName});
  final String? userName;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeNotifier,
      builder: (context, ThemeMode themeMode, Widget? child) {
        return ScreenUtilInit(
          designSize: const Size(375, 809),
          minTextAdapt: true,
          builder: (ctx, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeMode,
              title: 'Tasky App',
              home: userName == null ? WelcomeScreen() : MainScreen(),
            );
          },
        );
      },
    );
  }
}
