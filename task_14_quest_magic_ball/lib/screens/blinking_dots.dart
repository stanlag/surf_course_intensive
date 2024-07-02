import 'package:flutter/material.dart';

class BlinkingDots extends StatefulWidget {
  const BlinkingDots({super.key});

  @override
  State<BlinkingDots> createState() => _BlinkingDotsState();
}

class _BlinkingDotsState extends State<BlinkingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedDot(
            controller: _controller, startInterval: 0.0, endInterval: 0.3),
        const SizedBox(width: 8),
        AnimatedDot(
            controller: _controller, startInterval: 0.3, endInterval: 0.6),
        const SizedBox(width: 8),
        AnimatedDot(
            controller: _controller, startInterval: 0.6, endInterval: 1.0),
      ],
    );
  }
}

// Анимация точки
class AnimatedDot extends StatelessWidget {
  final AnimationController controller;
  final double startInterval;
  final double endInterval;

  const AnimatedDot({
    required this.controller,
    required this.startInterval,
    required this.endInterval,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(startInterval, endInterval, curve: Curves.easeInOut),
      ),
    );

    return FadeTransition(
      opacity: animation,
      child: const Dot(),
    );
  }
}

// Белая точка
class Dot extends StatelessWidget {
  const Dot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}
