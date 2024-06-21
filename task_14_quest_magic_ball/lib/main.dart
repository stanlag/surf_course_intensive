import 'package:flutter/material.dart';
import 'assets/themes/theme_data.dart';
import 'screens/magic_ball_screen.dart';

void main() {
  runApp(MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: AppThemeData.lightTheme,
      home: const MagicBallScreen(),
    );
  }
}