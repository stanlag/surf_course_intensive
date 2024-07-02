import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:task_14_quest_magic_ball/assets/app_images/app_images.dart';
import 'package:task_14_quest_magic_ball/screens/blinking_dots.dart';
import 'package:task_14_quest_magic_ball/assets/app_strings/app_strings.dart';
import 'package:task_14_quest_magic_ball/assets/colors/color_palette.dart';

class MagicBallScreen extends StatefulWidget {
  const MagicBallScreen({super.key});

  @override
  State<MagicBallScreen> createState() => _MagicBallScreenState();
}

class _MagicBallScreenState extends State<MagicBallScreen> {
  double _scale = 1.0;
  bool _isMagic = false;
  bool _isLoading = false;
  String _prediction = '';
  final Dio _dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _onTap,
                  child: _BallAnimated(
                    scale: _scale,
                  ),
                ),
                const SizedBox(height: 10),
                _TextOpacity(isMagic: _isMagic),
              ],
            ),
            if (_isMagic)
              Positioned.fill(
                child: GestureDetector(
                  onTap: _onTap,
                  child: _TextPrediction(
                    isLoading: _isLoading,
                    prediction: _prediction,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Запрос к API
  Future<void> _fetchMagic() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _dio.get(AppStrings.magicBallApi);
      if (response.statusCode == 200) {
        _prediction = response.data[AppStrings.reading];
      } else {
        _prediction = AppStrings.error;
      }
    } catch (e) {
      _prediction = AppStrings.error;
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onTap() {
    setState(() {
      _isMagic = !_isMagic;
      _scale = _isMagic ? 3.0 : 1.0;
      if (_isMagic) {
        _fetchMagic();
      }
    });
  }
}

// Анимация загрузки и ответа
class _TextPrediction extends StatelessWidget {
  const _TextPrediction({
    required bool isLoading,
    required String prediction,
  })  : _isLoading = isLoading,
        _prediction = prediction;

  final bool _isLoading;
  final String _prediction;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.black.withOpacity(0.5),
      child: _isLoading
          ? const BlinkingDots()
          : Text(_prediction,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: _prediction == AppStrings.error // Если ошибка то красный цвет
                        ? AppColor.red
                        : AppColor.white,
                  )),
    );
  }
}

//Анимация исчезновения текста
class _TextOpacity extends StatelessWidget {
  const _TextOpacity({
    required bool isMagic,
  }) : _isMagic = isMagic;

  final bool _isMagic;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isMagic ? 0.0 : 1.0,
      duration: const Duration(milliseconds: 300),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          AppStrings.touchCircle,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: AppColor.grey),
        ),
      ),
    );
  }
}

// Увеличение и уменьшение шара
class _BallAnimated extends StatelessWidget {
  const _BallAnimated({
    required double scale,
  }) : _scale = scale;

  final double _scale;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      transformAlignment: Alignment.center,
      transform: Matrix4.identity()..scale(_scale),
      child: Image.asset(AppImages.ball),
    );
  }
}
