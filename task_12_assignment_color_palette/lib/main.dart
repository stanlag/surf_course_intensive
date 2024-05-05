import 'package:flutter/material.dart';
import 'package:task_12_assignment_color_palette/ui/colors_screen.dart';
import 'package:task_12_assignment_color_palette/ui/detailed_color_screen.dart';
import 'package:task_12_assignment_color_palette/utils/navigation_route_name/navigation_route_name.dart';
import 'package:task_12_assignment_color_palette/api/color_api/color_api_assets.dart';
import 'package:task_12_assignment_color_palette/assets/themes/theme_data.dart';
import 'package:task_12_assignment_color_palette/data/mapper/color_mapper.dart';
import 'package:task_12_assignment_color_palette/data/repository/color_repository.dart';

void main() {
  runApp(const MyApp());
}

final colorsRepository = ColorsRepository(
  colorsApi: ColorsApiAssets(),
  colorsMapper: ColorMapper(),
);

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Color Palette',
      theme: AppThemeData.lightTheme,
      initialRoute: NavigationRouteNames.main,
      routes: {
        NavigationRouteNames.main: (_) => const ColorsScreen(),
        NavigationRouteNames.colorWidget: (_) => const DetailedColorScreen(),
      },
    );
  }
}
