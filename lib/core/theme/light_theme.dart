import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,

  scaffoldBackgroundColor: Color(0XFFF6F7F9),

  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0XFF15B86C);
      }
      return Colors.white;
    }),

    thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0XFFFFFCFC);
      }
      return Color(0XFF9E9E9E);
    }),

    trackOutlineColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.transparent;
      }
      return Color(0XFF9E9E9E);
    }),

    trackOutlineWidth: WidgetStateProperty.resolveWith<double>((states) {
      if (states.contains(WidgetState.selected)) {
        return 0;
      }
      return 2.0;
    }),
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: Color(0XFFF6F7F9),
    titleTextStyle: TextStyle(
      color: Color(0XFFFFFCFC),
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    centerTitle: false,
    iconTheme: IconThemeData(color: Color(0xffFFFCFC)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0XFF15B86C),
      foregroundColor: Color(0XFFFFFCFC),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  ),

  textTheme: TextTheme(
    displayMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      color: Color(0XFF161F1B),
    ),
    displaySmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: Color(0XFF161F1B),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0XFFFFFFFF),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),

    hintStyle: TextStyle(color: Color(0XFF9E9E9E)),
  ),
  // elevatedButtonTheme: ElevatedButtonThemeData(
  //   style: ButtonStyle(
  //     backgroundColor: WidgetStateProperty.all(Color(0XFF15B86C)),
  //     foregroundColor: WidgetStateProperty.all(Color(0XFFFFFCFC)),
  //     shape: WidgetStateProperty.all(
  //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //     ),
  //   ),
  // ),
);
