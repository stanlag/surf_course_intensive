import 'package:flutter/material.dart';
import 'package:task_12_assignment_color_palette/assets/colors/color_palette.dart';
import 'package:task_12_assignment_color_palette/assets/text/text_style.dart';

abstract class AppThemeData {
  static final ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColor.black,
        onPrimary: AppColor.black,
        secondary: AppColor.black,
        onSecondary: AppColor.black,
        error: AppColor.red,
        onError: AppColor.red,
        background: AppColor.white,
        onBackground: AppColor.white,
        surface: AppColor.white,
        onSurface: AppColor.black),
    textTheme: AppTextTheme.appTextTheme,
    appBarTheme: const AppBarTheme(
      foregroundColor: AppColor.white,
      color: Colors.white,
      centerTitle: true,
    ),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Ubuntu',
    useMaterial3: true,
  );
}
