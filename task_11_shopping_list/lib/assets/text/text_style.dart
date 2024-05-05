import 'package:flutter/material.dart';

/// App text style.
abstract class AppTextTheme {
  static const TextTheme appTextTheme = TextTheme(
    titleLarge: TextStyle(
      fontFamily: 'Sora',
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Sora',
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Sora',
      fontSize: 14,
      fontWeight: FontWeight.w700,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Sora',
      fontSize: 15,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Sora',
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
  );
}
