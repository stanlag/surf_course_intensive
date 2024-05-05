import 'dart:convert';

import 'package:flutter/services.dart';

import '../ data/color_data.dart';
import '../color_api_utils.dart';
import 'color_api.dart';

class ColorsApiAssets implements ColorsApi {
  @override
  Future<List<ColorData>> getColors() async {
    final colors = <ColorData>[];
    await _addDelay(1000);
    String jsonString = await _loadAsset(ColorsApiUrls.colors);
    final data = jsonDecode(jsonString) as Map<String, dynamic>;

    final colorsData = data['colors'] as List;

    if (colorsData.isNotEmpty) {
      for (final element in colorsData) {
        colors.add(ColorData.fromJson(element as Map<String, dynamic>));
      }
    }
    return colors;
  }

  /// Загружаем строку us asset приложения
  Future<String> _loadAsset(String path) => rootBundle.loadString(path);

  Future<void> _addDelay(int ms) =>
      Future<void>.delayed(Duration(milliseconds: ms));
}
