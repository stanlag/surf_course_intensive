import 'package:flutter/material.dart';
import 'package:task_14_quest_magic_ball/assets/colors/color_palette.dart';
import 'package:task_14_quest_magic_ball/assets/text/text_style.dart';

abstract class AppThemeData {
  static final ThemeData lightTheme = ThemeData(
    textTheme: AppTextTheme.appTextTheme,
    appBarTheme: const AppBarTheme(
      foregroundColor: AppColor.black,
      color: AppColor.white,
      centerTitle: true,
    ),
    scaffoldBackgroundColor: AppColor.dartBlue,
    useMaterial3: true,
  );
}
