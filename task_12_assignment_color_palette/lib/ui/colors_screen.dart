import 'package:flutter/material.dart';
import 'package:task_12_assignment_color_palette/resources/app_strings.dart';
import 'package:task_12_assignment_color_palette/domain/entity/color_entity.dart';
import 'package:task_12_assignment_color_palette/utils/extension/string_x.dart';
import 'package:task_12_assignment_color_palette/main.dart';
import 'package:task_12_assignment_color_palette/utils/navigation_route_name/navigation_route_name.dart';
import 'package:task_12_assignment_color_palette/utils/toast_msg/toast_msg.dart';

class ColorsScreen extends StatefulWidget {
  const ColorsScreen({Key? key}) : super(key: key);

  @override
  State<ColorsScreen> createState() => _ColorsScreenState();
}

class _ColorsScreenState extends State<ColorsScreen> {
  Future<List<ColorEntity>>? _data;

  @override
  void initState() {
    _load();
    super.initState();
  }

  Future<void> _load() async {
    _data = colorsRepository.getColors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              AppStrings.exclusiveColoredBoxPalette,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<ColorEntity>>(
        future: _data,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const _EventWidget(eventWidget: Text(AppStrings.error),);
            } else if (snapshot.hasData) {
              final data = snapshot.data;
              return data != null
                  ? _ContentWidget(data: data)
                  : const _EventWidget(eventWidget: Text(AppStrings.empty),);
            }
          }
          return const _EventWidget(eventWidget: CircularProgressIndicator(),);
        },
      ),
    );
  }
}

/// Виджет с контентом.Тут реализуем при копировании появления иконки копирования
class _ContentWidget extends StatefulWidget {
  final List<ColorEntity> data;
  const _ContentWidget({required this.data});

  @override
  State<_ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<_ContentWidget> {
  int copyIndex = -1; // Индекс цвета, на который выполнен долгий таб

  void _changeCopyIndex(int index) {
    setState(() {
      copyIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 30.0,
          crossAxisSpacing: 3.0,
        ),
        itemCount: widget.data.length,
        itemBuilder: (_, index) {
          final colorData = widget.data[index];
          return _ColorWidget(
            colorData: widget.data[index],
            onTap: () {
              Navigator.pushNamed(
                context,
                NavigationRouteNames.colorWidget,
                arguments: colorData,
              );
            },
            isCopy: index == copyIndex,
            onLongPress: () {
              _changeCopyIndex(index);
              clipbordDataAndToastMsg.copyToClipboard(colorData.value);
            },
          );
        },
      ),
    );
  }
}

class _ColorWidget extends StatelessWidget {
  final ColorEntity colorData;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final bool isCopy;

  const _ColorWidget({
    required this.colorData,
    required this.onTap,
    required this.onLongPress,
    required this.isCopy,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return GestureDetector(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Column(
        children: [
          Expanded(
            child: SizedBox.square(
              dimension: 100.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: colorData.value.hexToColor(),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(colorData.name, style: theme.bodySmall),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(colorData.value, style: theme.bodySmall),
              const SizedBox(
                width: 3,
              ),
              isCopy
                  ? const Icon(
                      Icons.copy,
                      size: 12,
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}

/// Виджет для разных событий (пустой,загрузка, ошибка)
class _EventWidget extends StatelessWidget {
  final Widget eventWidget;
  const _EventWidget({ required this.eventWidget});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: eventWidget,
    );
  }
}
