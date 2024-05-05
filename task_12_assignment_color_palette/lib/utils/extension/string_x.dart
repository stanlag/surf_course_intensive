import 'package:flutter/material.dart';

/// Extension for String
extension StringX on String {
  /// Преобразовать строку шестнадцатеричного цвета в объект Color
  Color hexToColor() {
    final hexCode = replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }
}
