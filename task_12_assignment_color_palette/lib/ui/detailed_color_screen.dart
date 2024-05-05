import 'package:flutter/material.dart';
import 'package:task_12_assignment_color_palette/resources/app_strings.dart';
import 'package:collection/collection.dart';
import 'package:task_12_assignment_color_palette/domain/entity/color_entity.dart';
import 'package:task_12_assignment_color_palette/domain/entity/rgb_type.dart';
import 'package:task_12_assignment_color_palette/utils/extension/string_x.dart';
import 'package:task_12_assignment_color_palette/utils/toast_msg/toast_msg.dart';

class DetailedColorScreen extends StatefulWidget {
  const DetailedColorScreen({super.key});

  @override
  State<DetailedColorScreen> createState() => _DetailedColorScreenState();
}

class _DetailedColorScreenState extends State<DetailedColorScreen> {
  int copyIndex = -1;

  void _changeCopyIndex(int index) {
    setState(() {
      copyIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorData = ModalRoute.of(context)!.settings.arguments as ColorEntity;
    final height = MediaQuery.of(context).size.height;
    final colorBoxHeight = height / 2;
    final preferredSizeHeight = colorBoxHeight - kToolbarHeight;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight, // дефолтная высота 56
        foregroundColor: Colors.white,
        flexibleSpace: SizedBox(
          height: colorBoxHeight,
          width: double.infinity,
          child: ColoredBox(
            color: colorData.value.hexToColor(),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(preferredSizeHeight),
          child: const SizedBox.shrink(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(colorData.name,
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(
                  height: 15,
                ),
                _ContainerWithTextWidget(
                  colorName: colorData.value,
                  colorOptions: AppStrings.hex,
                  copyOn: copyIndex == 0,
                  onLongPress: () {
                    _changeCopyIndex(0);
                    clipbordDataAndToastMsg.copyToClipboard(colorData.value);
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                _RgbWidget(color: colorData.value.hexToColor()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RgbWidget extends StatefulWidget {
  final Color color;

  const _RgbWidget({Key? key, required this.color}) : super(key: key);

  @override
  State<_RgbWidget> createState() => _RgbWidgetState();
}

class _RgbWidgetState extends State<_RgbWidget> {
  int copyIndex = -1;

  void _changeCopyIndex(int index) {
    setState(() {
      copyIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: RgbType.values
          .expandIndexed(
            (i, e) => [
              Expanded(
                child: _ContainerWithTextWidget(
                  colorOptions: e.name,
                  colorName: switch (e) {
                    RgbType.red => widget.color.red.toString(),
                    RgbType.green => widget.color.green.toString(),
                    RgbType.blue => widget.color.blue.toString(),
                  },
                  onLongPress: () {
                    String copiedColor;
                    switch (e) {
                      case RgbType.red:
                        copiedColor = widget.color.red.toString();
                        _changeCopyIndex(0);
                        break;
                      case RgbType.green:
                        copiedColor = widget.color.green.toString();
                        _changeCopyIndex(1);
                        break;
                      case RgbType.blue:
                        copiedColor = widget.color.blue.toString();
                        _changeCopyIndex(2);
                        break;
                    }
                    clipbordDataAndToastMsg.copyToClipboard(copiedColor);
                  },
                  copyOn: i == copyIndex,
                ),
              ),
              if (i != RgbType.values.length - 1) const SizedBox(width: 8),
            ],
          )
          .toList(),
    );
  }
}

/// Контейнер с текстом
class _ContainerWithTextWidget extends StatelessWidget {
  const _ContainerWithTextWidget({
    required this.colorName,
    required this.colorOptions,
    required this.onLongPress,
    required this.copyOn,
  });

  final String colorName;
  final String colorOptions;
  final VoidCallback onLongPress;
  final bool copyOn;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(colorOptions),
              const SizedBox(width: 5),
              Row(
                children: [
                  Text(colorName),
                  const SizedBox(width: 3),
                  copyOn
                      ? const Icon(
                          Icons.copy,
                          size: 12,
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
