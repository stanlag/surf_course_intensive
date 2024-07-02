import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_15_validation_of_forms/presentation/pet_form_screen.dart';
import 'assets/themes/theme_data.dart';
import 'model_provider/pets_model.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.lightTheme,
      themeMode: ThemeMode.system,
      home: ChangeNotifierProvider(
          create: (context) => PetsModel(), child: const PetFormScreen()),
    );
  }
}
