import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primaryContainer: Color(0XFFFFFFFF),
    secondary: Color(0XFF3A4640),
  ),

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
      color: Color(0XFF161F1B),
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    centerTitle: false,
    iconTheme: IconThemeData(color: Color(0xFF161F1B)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0XFF15B86C),
      foregroundColor: Color(0XFFFFFCFC),
      textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: Colors.black),
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0XFF15B86C),
    foregroundColor: Color(0xffFFFCFC),
    extendedTextStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
  ),

  textTheme: TextTheme(
    displaySmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: Color(0XFF161F1B),
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      color: Color(0XFF161F1B),
    ),
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      color: Color(0XFF161F1B),
    ),

    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Color(0XFF3A4640),
    ),

    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0XFF161F1B),
    ),
    //for done tasks
    titleLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0XFFA0A0A0),
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0XFF49454F),
      overflow: TextOverflow.ellipsis,
    ),
    labelSmall: TextStyle(
      color: Color(0XFF161F1B),
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(color: Colors.black, fontSize: 16),
    labelLarge: TextStyle(color: Colors.black, fontSize: 24),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0XFFFFFFFF),
    hintStyle: TextStyle(color: Color(0XFF9E9E9E)),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0XFFD1DAD6), width: 0.5),
    ),

    // focusColor: Colors.black,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0XFFD1DAD6), width: 0.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0XFFD1DAD6), width: 0.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red, width: 0.5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red, width: 0.5),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    side: BorderSide(color: Color(0XFFD1DAD6), width: 2),
  ),
  iconTheme: IconThemeData(color: Color(0XFF161F1B)),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      color: Color(0XFF161F1B),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  ),
  dividerTheme: DividerThemeData(
    color: Color(0XFFD1DAD6),
    thickness: 1,
    space: 1,
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.grey[300]!,
    selectionHandleColor: Colors.black,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0XFFF6F7F9),
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Color(0XFF14A662),
    unselectedItemColor: Color(0XFF3A4640),
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0XFFF6F7F9),

    // textStyle: TextStyle(
    //   color: Colors.black,
    //   fontSize: 16,
    //   fontWeight: FontWeight.w400,
    // ),
    labelTextStyle: WidgetStatePropertyAll(
      TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400),
    ),
    menuPadding: EdgeInsets.all(4),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      // side: BorderSide(color: Color(0XFF15B86C), width: 1),
    ),
    elevation: 2,
    shadowColor: Color(0XFF15B86C),
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
