import 'package:flutter/material.dart';

/// App text style.
abstract class AppTextTheme {
  static const TextTheme appTextTheme = TextTheme(
    titleLarge: TextStyle(
      fontFamily: 'SF Pro Display',
      fontSize: 16,
      fontWeight: FontWeight.w700,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'SF Pro Display',
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontFamily: 'SF Pro Display',
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  );
}
