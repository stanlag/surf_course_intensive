import 'package:task_12_assignment_color_palette/api/%20data/color_data.dart';
import 'package:task_12_assignment_color_palette/domain/entity/color_entity.dart';

/// Маппер сущностей
final class ColorMapper {
  /// Малпер для списка цветов
  List<ColorEntity> mapColors(List<ColorData> data) {
    final mappedList = <ColorEntity>[];
    for (var e in data) {
      final entity = _mapColor(e);
      if (entity != null) mappedList.add(entity);
    }
    return mappedList;
  }

  /// Маплер [ColorEntity] u [ColorData]
  ColorEntity? _mapColor(ColorData data) {
    final value = data.value;
    if (value == null) return null;
    return ColorEntity(
      name: data.name,
      value: value,
    );
  }
}
