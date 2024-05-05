import 'package:task_12_assignment_color_palette/resources/app_strings.dart';

/// RGB
enum RgbType {
  red(AppStrings.redColorsScreen),
  green(AppStrings.greenColorsScreen),
  blue(AppStrings.blueColorsScreen);

  final String name;

  const RgbType(this.name);
}
