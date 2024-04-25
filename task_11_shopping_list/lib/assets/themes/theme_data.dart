import 'package:flutter/material.dart';

import '../colors/app_colors.dart';
import '../text/text_style.dart';

abstract class AppThemeData {
  static final ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.lightGreen,
        onPrimary: AppColors.white,
        secondary: AppColors.darkGrey,
        onSecondary: AppColors.black,
        error: AppColors.red,
        onError: AppColors.red,
        background: AppColors.white,
        onBackground: AppColors.lightGrey,
        surface: AppColors.lightGreen,
        onSurface: AppColors.black),
    textTheme: AppTextTheme.appTextTheme,
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      centerTitle: true,
    ),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Sora',
    useMaterial3: true,
  );
}
