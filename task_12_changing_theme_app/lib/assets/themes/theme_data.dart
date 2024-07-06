import 'package:flutter/material.dart';
import 'package:task_12_changing_theme_app/assets/colors/app_colors.dart';
import 'package:task_12_changing_theme_app/assets/text/text_style.dart';

abstract class AppThemeData {
  static final ThemeData lightTheme = ThemeData.light();
  static final ThemeData darkTheme = ThemeData.dark();

  static ThemeData generateTheme({
    required bool isDark,
    required Color onPrimary,
    required Color secondary,
    required Color surface,
    required Color scaffoldBackgroundColor,
  }) {
    final baseTheme = isDark ? ThemeData.dark() : ThemeData.light();
    return baseTheme.copyWith(
      colorScheme: baseTheme.colorScheme.copyWith(
        primary: isDark ? AppColors.white : AppColors.black,
        onPrimary: onPrimary,
        secondary: secondary,
        surface: surface,
      ),
      textTheme: AppTextTheme.appTextTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: scaffoldBackgroundColor,
        centerTitle: true,
      ),
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.red),
          foregroundColor: AppColors.red,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: onPrimary,
          textStyle: const TextStyle(color: AppColors.white),
        ),
      ),
      cardTheme: CardTheme(color: secondary),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scaffoldBackgroundColor,
        modalBackgroundColor: scaffoldBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40),
          ),
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.all(onPrimary),
      ),
    );
  }

  /// Системная тема
  static final ThemeData systemTheme = generateTheme(
    isDark: false,
    onPrimary: AppColors.firstSystem,
    secondary: AppColors.white,
    surface: AppColors.backSystem,
    scaffoldBackgroundColor: AppColors.backSystem,
  );

  /// Светлая тема основной зеленой
  static final ThemeData lightGreenTheme = generateTheme(
    isDark: false,
    onPrimary: AppColors.firstGreenLight,
    secondary: AppColors.secondGreenLight,
    surface: AppColors.backGreenLight,
    scaffoldBackgroundColor: AppColors.backGreenLight,
  );

  /// Светлая тема основной синей
  static final ThemeData lightBlueTheme = generateTheme(
    isDark: false,
    onPrimary: AppColors.firstBlueLight,
    secondary: AppColors.secondBlueLight,
    surface: AppColors.backBlueLight,
    scaffoldBackgroundColor: AppColors.backBlueLight,
  );

  /// Светлая тема основной оранжевой
  static final ThemeData lightOrangeTheme = generateTheme(
    isDark: false,
    onPrimary: AppColors.firstOrangeLight,
    secondary: AppColors.secondOrangeLight,
    surface: AppColors.backOrangeLight,
    scaffoldBackgroundColor: AppColors.backOrangeLight,
  );

  /// Темная тема основной зеленой
  static final ThemeData darkGreenTheme = generateTheme(
    isDark: true,
    onPrimary: AppColors.firstGreenDark,
    secondary: AppColors.secondGreenDark,
    surface: AppColors.backGreenDark,
    scaffoldBackgroundColor: AppColors.backGreenDark,
  );

  /// Темная тема основной синей
  static final ThemeData darkBlueTheme = generateTheme(
    isDark: true,
    onPrimary: AppColors.firstBlueDark,
    secondary: AppColors.secondBlueDark,
    surface: AppColors.backBlueDark,
    scaffoldBackgroundColor: AppColors.backBlueDark,
  );

  /// Темная тема основной оранжевой
  static final ThemeData darkOrangeTheme = generateTheme(
    isDark: true,
    onPrimary: AppColors.firstOrangeDark,
    secondary: AppColors.secondOrangeDark,
    surface: AppColors.backOrangeDark,
    scaffoldBackgroundColor: AppColors.backOrangeDark,
  );
}
