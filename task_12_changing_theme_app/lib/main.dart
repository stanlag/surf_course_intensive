import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_12_changing_theme_app/ui/main_screen/main_screen.dart';
import 'model_provider/profile_model_provider.dart';

void main() {
  runApp(
    const MyAppProvider(),
  );
}

class MyAppProvider extends StatelessWidget {
  const MyAppProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyApp();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  late ModelProvider modelProvider;

  @override
  void initState() {
    super.initState();
    modelProvider = ModelProvider(this);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: modelProvider,
      child: Consumer<ModelProvider>(
        builder: (context, model, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: model.themeData,
            home: const ProfileScreen(),
          );
        },
      ),
    );
  }
}
