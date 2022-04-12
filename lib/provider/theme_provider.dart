import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

extension ThemeModeExtension on ThemeMode {
  get value => <String>['System', 'Light', 'Dark'][index];
}

class ThemeProvider extends ChangeNotifier {
  var box = Hive.box('common_box');

  void syncTheme() async {
    final String theme = box.get('app_theme');
    if (theme.isNotEmpty && theme != ThemeMode.system.value) {
      notifyListeners();
    }
  }

  void setTheme(ThemeMode themeMode) async {
    box.put('app_theme', themeMode.value);
    notifyListeners();
  }

  ThemeMode getTheme() {
    // * add '?' that string can be null
    final String? theme = box.get('app_theme');
    switch (theme) {
      case 'Light':
        return ThemeMode.light;
      case 'Dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
