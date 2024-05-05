import 'package:flutter/material.dart';

/// App text style.
abstract class AppTextTheme {
  static const TextTheme appTextTheme = TextTheme(
    titleLarge: TextStyle(
      fontFamily: 'Ubuntu',
      fontSize: 30,
      fontWeight: FontWeight.w700,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Ubuntu',
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Ubuntu',
      fontSize: 14,
      fontWeight: FontWeight.w700,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Ubuntu',
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Ubuntu',
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  );
}
