import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_12_changing_theme_app/assets/colors/app_colors.dart';
import 'package:task_12_changing_theme_app/assets/res/app_strings.dart';
import 'package:task_12_changing_theme_app/domain/entity/theme_mode_select.dart';
import 'package:task_12_changing_theme_app/domain/entity/type_them.dart';
import 'package:task_12_changing_theme_app/model_provider/profile_model_provider.dart';

/// Виджет, отображающий нижний лист для выбора темы и цветовой схемы
class BuildBottomSheetWidget extends StatelessWidget {
  const BuildBottomSheetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelProvider>();
    return Container(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      child: Column(
        children: [
          // Заголовок и кнопка закрытия
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppStrings.theme,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    )),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Опции выбора режима темы
          RadioListTile(
              title: const Text(AppStrings.systemTheme),
              value: TypeTheme.system,
              groupValue: model.typeTheme,
              onChanged: (value) {
                model.setTheme(ThemeModeSelect.systemTheme);
                model.setTypeTheme(value as TypeTheme);
              }),
          RadioListTile(
              title: const Text(AppStrings.lightTheme),
              value: TypeTheme.light,
              groupValue: model.typeTheme,
              onChanged: (value) {
                model.setTheme(ThemeModeSelect
                    .lightThemeGreen); // Тема по умолчанию для светлой темы
                model.setTypeTheme(value as TypeTheme);
              }),
          model.typeTheme == TypeTheme.light
              ? const ColorSchemeSelector(typeTheme: TypeTheme.light)
              : const SizedBox
              .shrink(), // Отображение выбора цветовой схемы при светлой теме
          RadioListTile(
              title: const Text(AppStrings.dartTheme),
              value: TypeTheme.dark,
              groupValue: model.typeTheme,
              onChanged: (value) {
                model.setTheme(ThemeModeSelect
                    .darkThemeGreen); // Тема по умолчанию для темной темы
                model.setTypeTheme(value as TypeTheme);
              }),
          model.typeTheme == TypeTheme.dark
              ? const ColorSchemeSelector(typeTheme: TypeTheme.dark)
              : const SizedBox
              .shrink(), // Отображение выбора цветовой схемы при темной теме
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                AppStrings.done,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Виджет для выбора цветовой схемы
class ColorSchemeSelector extends StatefulWidget {
  final TypeTheme typeTheme;

  const ColorSchemeSelector({super.key, required this.typeTheme});

  @override
  State<ColorSchemeSelector> createState() => _ColorSchemeSelectorState();
}

class _ColorSchemeSelectorState extends State<ColorSchemeSelector> {
  int _selectedScheme = 1;

  // Метод для изменения выбранной цветовой схемы
  void _selectScheme(int scheme) {
    setState(() {
      _selectedScheme = scheme;
    });
    final model = context.read<ModelProvider>();
    switch (scheme) {
      case 1:
        model.setTheme(widget.typeTheme == TypeTheme.light
            ? ThemeModeSelect.lightThemeGreen
            : ThemeModeSelect.darkThemeGreen);
        break;
      case 2:
        model.setTheme(widget.typeTheme == TypeTheme.light
            ? ThemeModeSelect.lightThemeBlue
            : ThemeModeSelect.darkThemeBlue);
        break;
      case 3:
        model.setTheme(widget.typeTheme == TypeTheme.light
            ? ThemeModeSelect.lightThemeOrange
            : ThemeModeSelect.darkThemeOrange);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.colorScheme,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _BuildSchemeOption(
              schemeNumber: 1,
              isSelected: _selectedScheme == 1,
              onTap: () => _selectScheme(1),
              colors: const [
                AppColors.grey,
                AppColors.firstGreenLight,
                AppColors.white,
                AppColors.grey,
              ],
            ),
            _BuildSchemeOption(
              schemeNumber: 2,
              isSelected: _selectedScheme == 2,
              onTap: () => _selectScheme(2),
              colors: const [
                AppColors.firstBlueLight,
                AppColors.blue,
                AppColors.white,
                AppColors.grey,
              ],
            ),
            _BuildSchemeOption(
              schemeNumber: 3,
              isSelected: _selectedScheme == 3,
              onTap: () => _selectScheme(3),
              colors: const [
                AppColors.firstOrangeLight,
                AppColors.orange,
                AppColors.white,
                AppColors.grey,
              ],
            ),
          ],
        ),
      ],
    );
  }
}

/// Виджет для отображения выбранной цветовой схемы
class _BuildSchemeOption extends StatelessWidget {
  final int schemeNumber;
  final bool isSelected;
  final VoidCallback onTap;
  final List<Color> colors;

  const _BuildSchemeOption({
    required this.isSelected,
    required this.onTap,
    required this.schemeNumber,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 4.0,
          bottom: 4.0,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.surface,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                _BuildColorCircle(color: colors[0]),
                _BuildColorCircle(color: colors[1]),
              ],
            ),
            Row(
              children: [
                _BuildColorCircle(color: colors[2]),
                _BuildColorCircle(color: colors[3]),
              ],
            ),
            const SizedBox(height: 8.0),
            Text('Схема $schemeNumber',style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Theme.of(context).colorScheme.primary,)),
          ],
        ),
      ),
    );
  }
}

/// Виджет для отображения цветового круга
class _BuildColorCircle extends StatelessWidget {
  final Color color;
  const _BuildColorCircle({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1.0),
      width: 10.0,
      height: 10.0,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
