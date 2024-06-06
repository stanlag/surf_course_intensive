import 'package:flutter/material.dart';
import 'package:task_13_photo_gallery/presentation/photos_screen.dart';

import 'assets/themes/theme_data.dart';
import 'data/repository/photos_repository.dart';

void main() {
  runApp(const MyApp());
}

final photoRepository = PhotosRepository();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppThemeData.lightTheme,
      home: const PhotosScreen(),
    );
  }
}
