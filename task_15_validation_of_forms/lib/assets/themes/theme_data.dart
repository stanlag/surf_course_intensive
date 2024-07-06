import 'package:flutter/material.dart';

import 'package:task_15_validation_of_forms/assets/colors/app_color.dart';
import 'package:task_15_validation_of_forms/assets/text/text_style.dart';

abstract class AppThemeData {
  static final ThemeData lightTheme = ThemeData(
    textTheme: AppTextTheme.appTextTheme,
    appBarTheme: const AppBarTheme(
      foregroundColor: AppColor.black,
      color: AppColor.white,
      centerTitle: true,
    ),
    scaffoldBackgroundColor: AppColor.grey,
    useMaterial3: true,
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: AppColor.white,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 1, color: AppColor.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 1, color: AppColor.white),
      ),
      labelStyle:
          TextStyle(color: AppColor.darkGrey, fontWeight: FontWeight.normal),
      hintStyle:
          TextStyle(color: AppColor.darkGrey, fontWeight: FontWeight.normal),
      errorStyle: TextStyle(color: AppColor.red),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(AppColor.white),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColor.red;
        }
        return AppColor.white;
      }),
      side: WidgetStateBorderSide.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const BorderSide(color: AppColor.red);
        }
        return const BorderSide(color: AppColor.grey);
      }),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(AppColor.red),
        foregroundColor: WidgetStateProperty.all<Color>(AppColor.white),
      ),
    ),
    datePickerTheme: const DatePickerThemeData(
      backgroundColor: AppColor.grey,
      headerBackgroundColor: AppColor.red,
      headerForegroundColor: AppColor.grey,
    ),

  );
}
