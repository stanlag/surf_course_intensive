import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_12_changing_theme_app/domain/entity/theme_mode_select.dart';
import 'package:task_12_changing_theme_app/domain/entity/type_them.dart';

class PreferencesService {
  Future<int> getThemeModeSelectIndex() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('themeModeSelect') ?? ThemeModeSelect.systemTheme.index;
  }

  Future<int> getTypeThemeIndex() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('typeTheme') ?? TypeTheme.system.index;
  }

  Future<void> setThemeModeSelectIndex(int index) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('themeModeSelect', index);
  }

  Future<void> setTypeThemeIndex(int index) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('typeTheme', index);
  }
}
