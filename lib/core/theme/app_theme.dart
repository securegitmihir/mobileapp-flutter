import 'package:auth_todo/core/theme/color_pallete.dart';
import 'package:flutter/material.dart';

enum ThemeType { light, dark }

class _ThemeHelper {
  static OutlineInputBorder _border(pallete) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: pallete.primary, width: 3),
      borderRadius: BorderRadius.circular(10),
    );
  }

  static ColorScheme _colorScheme(pallete, theme) {
    return ColorScheme(
      brightness: theme == ThemeType.dark ? Brightness.dark : Brightness.light,
      primary: pallete.primary,
      primaryContainer: pallete.primaryVariant,
      secondary: pallete.secondary,
      secondaryContainer: pallete.secondaryVariant,
      surface: pallete.surface,
      error: pallete.error,
      onPrimary: pallete.onPrimary,
      onSecondary: pallete.onSecondary,
      onSurface: pallete.onSurface,
      onError: pallete.onError,
    );
  }

  static ElevatedButtonThemeData _elevatedButtonTheme(pallete) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: pallete.button,
        foregroundColor: pallete.onButton,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  static TextTheme _textTheme(TextTheme textTheme) {
    return textTheme.copyWith(
      bodyLarge: textTheme.bodyLarge?.copyWith(fontFamily: 'Poppins'),
      bodyMedium: textTheme.bodyMedium?.copyWith(fontFamily: 'Poppins'),
      bodySmall: textTheme.bodySmall?.copyWith(fontFamily: 'Poppins'),

      headlineLarge: textTheme.headlineLarge?.copyWith(
        fontFamily: 'Montserrat',
      ),
      headlineMedium: textTheme.headlineMedium?.copyWith(
        fontFamily: 'Montserrat',
      ),
      headlineSmall: textTheme.headlineSmall?.copyWith(
        fontFamily: 'Montserrat',
      ),

      titleLarge: textTheme.titleLarge?.copyWith(fontFamily: 'Montserrat'),
      titleMedium: textTheme.titleMedium?.copyWith(fontFamily: 'Montserrat'),
      titleSmall: textTheme.titleSmall?.copyWith(fontFamily: 'Montserrat'),
    );
  }
}

class AppTheme {
  static get darkThemeMode {
    final pallete = ColorPallete.getThemePallete(ThemeType.dark);
    return ThemeData.dark().copyWith(
      textTheme: _ThemeHelper._textTheme(ThemeData.dark().textTheme),
      colorScheme: _ThemeHelper._colorScheme(pallete, ThemeType.dark),
      scaffoldBackgroundColor: pallete.surface,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(27),
        enabledBorder: _ThemeHelper._border(pallete),
        focusedBorder: _ThemeHelper._border(pallete),
      ),
      elevatedButtonTheme: _ThemeHelper._elevatedButtonTheme(pallete),
    );
  }

  static get lightThemeMode {
    final pallete = ColorPallete.getThemePallete(ThemeType.light);
    return ThemeData.light().copyWith(
      textTheme: _ThemeHelper._textTheme(ThemeData.light().textTheme),
      colorScheme: _ThemeHelper._colorScheme(pallete, ThemeType.light),
      scaffoldBackgroundColor: pallete.surface,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(27),
        enabledBorder: _ThemeHelper._border(pallete),
        focusedBorder: _ThemeHelper._border(pallete),
      ),
      elevatedButtonTheme: _ThemeHelper._elevatedButtonTheme(pallete),
    );
  }
}
