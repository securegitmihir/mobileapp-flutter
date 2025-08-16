import 'package:auth_todo/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ThemeState extends ChangeNotifier {
  ThemeType themeType = ThemeType.light;

  void changeTheme() {
    themeType = themeType == ThemeType.light ? ThemeType.dark : ThemeType.light;
    notifyListeners();
  }
}
