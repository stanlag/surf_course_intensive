import 'package:flutter/material.dart';
import '../assets/themes/theme_data.dart';
import '../domain/entity/theme_mode_select.dart';
import '../domain/entity/type_them.dart';
import '../utils/preferences_service.dart';

class ModelProvider extends ChangeNotifier {
  ThemeData _themeData = AppThemeData.systemTheme;
  TypeTheme _typeTheme = TypeTheme.system;
  ThemeModeSelect _themeModeSelect = ThemeModeSelect.systemTheme;

  final PreferencesService _preferencesService = PreferencesService();
  final TickerProvider tickerProvider;

  ModelProvider(this.tickerProvider) {
    _loadPreferences();
  }

  ThemeData get themeData => _themeData;
  TypeTheme get typeTheme => _typeTheme;
  ThemeModeSelect get themeModeSelect => _themeModeSelect;

  Future<void> _loadPreferences() async {
    final themeIndex = await _preferencesService.getThemeModeSelectIndex();
    final typeThemeIndex = await _preferencesService.getTypeThemeIndex();

    setTheme(ThemeModeSelect.values[themeIndex]);
    setTypeTheme(TypeTheme.values[typeThemeIndex]);
  }

  Future<void> _savePreferences() async {
    await _preferencesService.setThemeModeSelectIndex(_themeModeSelect.index);
    await _preferencesService.setTypeThemeIndex(_typeTheme.index);
  }

  void setTypeTheme(TypeTheme typeTheme) {
    _typeTheme = typeTheme;
    notifyListeners();
    _savePreferences();
  }

  void setTheme(ThemeModeSelect themeModeSelect) {
    _themeModeSelect = themeModeSelect;
    ThemeData newTheme;
    switch (themeModeSelect) {
      case ThemeModeSelect.systemTheme:
        newTheme = AppThemeData.systemTheme;
        break;
      case ThemeModeSelect.lightThemeGreen:
        newTheme = AppThemeData.lightGreenTheme;
        break;
      case ThemeModeSelect.lightThemeBlue:
        newTheme = AppThemeData.lightBlueTheme;
        break;
      case ThemeModeSelect.lightThemeOrange:
        newTheme = AppThemeData.lightOrangeTheme;
        break;
      case ThemeModeSelect.darkThemeGreen:
        newTheme = AppThemeData.darkGreenTheme;
        break;
      case ThemeModeSelect.darkThemeBlue:
        newTheme = AppThemeData.darkBlueTheme;
        break;
      case ThemeModeSelect.darkThemeOrange:
        newTheme = AppThemeData.darkOrangeTheme;
        break;
      default:
        newTheme = AppThemeData.systemTheme;
        break;
    }
    _animateThemeChange(newTheme);
    _savePreferences();
  }
/// анимация для плавноего перехода темы
  void _animateThemeChange(ThemeData newTheme) {
    final oldTheme = _themeData;
    final animationController = AnimationController(
      vsync: tickerProvider,
      duration: const Duration(milliseconds: 700),
    );

    animationController.addListener(() {
      _themeData =
          ThemeData.lerp(oldTheme, newTheme, animationController.value);
      notifyListeners();
    });

    animationController.forward();
  }
}
