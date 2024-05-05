import 'package:json_annotation/json_annotation.dart';

/// Тут будет размещён сгененированный код
part 'color_data.g.dart';

/// Аннотация для генерации.
@JsonSerializable(createToJson: false)
class ColorData {
  final String name;
  final String? value;

  ColorData(
    this.name,
    this.value,
  );

  factory ColorData.fromJson(Map<String, dynamic> json) =>
      _$ColorDataFromJson(json);
}
