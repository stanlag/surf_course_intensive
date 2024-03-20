import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  bool selected = false; // Флаг для отслеживания выбора
  double x = 100.0; // Начальная позиция X
  double y = 200.0; // Начальная позиция Y

  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Инициализация контроллера анимации и анимации
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    // Освобождение ресурсов при уничтожении виджета
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    // Генерация случайных значений для ширины, высоты и цвета контейнера
    double width = Random().nextDouble() * 100;
    double height = Random().nextDouble() * 100;
    Color color = Color.fromRGBO(
      Random().nextInt(256),
      Random().nextInt(256),
      Random().nextInt(256),
      1,
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('GestureMaster'),
          centerTitle: true,
          backgroundColor: Colors.deepPurple.shade300,
          foregroundColor: Colors.white,
        ),
        body: Stack(
          children: [
            Positioned(
              left: x,
              top: y,
              child: RotationTransition(
                turns: _animation,
                child: AnimatedContainer(
                  width: selected ? width : 50,
                  height: selected ? height : 50,
                  color: selected ? color : color,
                  duration: const Duration(seconds: 1),
                ),
              ),
            ),
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selected = !selected;
                  });
                },
                onPanUpdate: (details) {
                  // Обновление позиции X и Y при движении пальцем
                  setState(() {
                    x += details.delta.dx;
                    y += details.delta.dy;
                  });
                },
                onLongPress: () {
                  setState(() {
                    if (_controller.isAnimating) {
                      _controller.stop(); // Остановка анимации при долгом нажатии, если она в процессе
                    } else {
                      _controller.repeat(reverse: true); // Запуск или возобновление анимации при долгом нажатии
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
