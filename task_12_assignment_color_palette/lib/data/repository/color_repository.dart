import 'package:task_12_assignment_color_palette/api/color_api/color_api.dart';
import 'package:task_12_assignment_color_palette/domain/entity/color_entity.dart';
import 'package:task_12_assignment_color_palette/data/mapper/color_mapper.dart';

/// Репозиторий для получения данных
final class ColorsRepository {
  final ColorsApi _colorsApi;
  final ColorMapper _colorsMapper;
  ColorsRepository({
    required ColorsApi colorsApi,
    required ColorMapper colorsMapper,
  })  : _colorsApi = colorsApi,
        _colorsMapper = colorsMapper;
  Future<List<ColorEntity>> getColors() =>
      _colorsApi.getColors().then(_colorsMapper.mapColors);
}
