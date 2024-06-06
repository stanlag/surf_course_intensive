import 'package:flutter/material.dart';

import 'package:task_13_photo_gallery/assets/colors/color_palette.dart';
import 'package:task_13_photo_gallery/assets/text/text_style.dart';

abstract class AppThemeData {
  static final ThemeData lightTheme = ThemeData(
    textTheme: AppTextTheme.appTextTheme,
    appBarTheme: const AppBarTheme(
      foregroundColor: AppColor.black,
      color: AppColor.white,
      centerTitle: true,
    ),
    scaffoldBackgroundColor: AppColor.white,
    useMaterial3: true,
  );
}
