import 'package:flutter/material.dart';
import 'package:tasky/core/constants/app_sizes.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primaryContainer: Color(0XFF282828),
    secondary: Color(0XFFC6C6C6),
  ),
  scaffoldBackgroundColor: Color(0XFF181818),

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
    backgroundColor: Color(0XFF181818),
    titleTextStyle: TextStyle(
      color: Color(0XFFFFFCFC),
      fontSize: AppSizes.sp20,
      fontWeight: FontWeight.w400,
    ),
    centerTitle: false,
    iconTheme: IconThemeData(color: Color(0xffFFFCFC)),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0XFF15B86C),
      foregroundColor: Color(0XFFFFFCFC),
      textStyle: TextStyle(
        fontSize: AppSizes.sp14,
        fontWeight: FontWeight.w500,
      ),
      minimumSize: Size.fromHeight(AppSizes.h48),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.r16),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: Color(0XFFFFFCFC)),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0XFF15B86C),
    foregroundColor: Color(0xffFFFCFC),
    extendedTextStyle: TextStyle(
      fontSize: AppSizes.sp14,
      fontWeight: FontWeight.w500,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.r30),
    ),
  ),
  textTheme: TextTheme(
    displaySmall: TextStyle(
      fontSize: AppSizes.sp24,
      fontWeight: FontWeight.w400,
      color: Color(0XFFFFFCFC),
    ),
    displayMedium: TextStyle(
      fontSize: AppSizes.sp28,
      fontWeight: FontWeight.w400,
      color: Color(0XFFFFFFFF),
    ),
    displayLarge: TextStyle(
      fontSize: AppSizes.sp32,
      fontWeight: FontWeight.w400,
      color: Color(0XFFFFFCFC),
    ),

    titleSmall: TextStyle(
      fontSize: AppSizes.sp14,
      fontWeight: FontWeight.w400,
      color: Color(0XFFC6C6C6),
    ),
    titleMedium: TextStyle(
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w400,
      color: Color(0XFFFFFCFC),
    ),

    //for done tasks
    titleLarge: TextStyle(
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w400,
      color: Color(0XFFA0A0A0),
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0XFF49454F),
      overflow: TextOverflow.ellipsis,
    ),
    labelSmall: TextStyle(
      color: Color(0XFFFFFCFC),
      fontSize: AppSizes.sp20,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(color: Colors.white, fontSize: AppSizes.sp16),
    labelLarge: TextStyle(color: Colors.white, fontSize: AppSizes.sp24),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0XFF282828),
    hintStyle: TextStyle(color: Color(0XFF6D6D6D)),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide.none,
    ),

    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide(color: Colors.red, width: 0.5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide(color: Colors.red, width: 0.5),
    ),
  ),

  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.r4),
    ),
    side: BorderSide(color: Color(0XFF6E6E6E), width: AppSizes.w2),
  ),
  iconTheme: IconThemeData(color: Color(0XFFFFFCFC)),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      color: Color(0XFFFFFCFC),
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w400,
    ),
  ),
  dividerTheme: DividerThemeData(
    color: Color(0XFF6E6E6E),
    thickness: 1,
    space: 1,
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white,
    selectionColor: Colors.grey[300]!,
    selectionHandleColor: Colors.white,
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0XFF181818),
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Color(0XFF15B86C),
    unselectedItemColor: Color(0XFFC6C6C6),
  ),
  splashFactory: NoSplash.splashFactory,

  popupMenuTheme: PopupMenuThemeData(
    color: Color(0XFF181818),

    // textStyle: TextStyle(
    //   color: Color(0XFFFFFCFC),
    //   fontSize: AppSizes.sp10,
    //   fontWeight: FontWeight.w400,
    // ),
    labelTextStyle: WidgetStatePropertyAll(
      TextStyle(
        color: Color(0XFFFFFCFC),
        fontSize: AppSizes.sp18,
        fontWeight: FontWeight.w400,
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(color: Color(0XFF15B86C), width: 1),
    ),
    elevation: 2,
    shadowColor: Color(0XFF15B86C),
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: Color(0XFF181818),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.r16)),
    ),
  ),
  // elevatedButtonTheme: ElevatedButtonThemeData(
  //   style: ButtonStyle(
  //     backgroundColor: WidgetStateProperty.all(Color(0XFF15B86C)),
  //     foregroundColor: WidgetStateProperty.all(Color(0XFFFFFCFC)),
  //     textStyle: WidgetStateProperty.all(TextStyle(fontSize: AppSizes.sp14)),
  //     shape: WidgetStateProperty.all(
  //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //     ),
  //   ),
  // ),
);
