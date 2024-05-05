import 'package:task_12_assignment_color_palette/api/%20data/color_data.dart';

abstract class ColorsApi {
  /// Получить список цветов
  Future<List<ColorData>> getColors();
}
