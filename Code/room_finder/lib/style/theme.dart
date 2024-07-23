import 'package:flutter/material.dart';

class GlobalThemeData {
  static final Color _lightFocusColor =
      const Color.fromARGB(255, 0, 0, 0).withOpacity(0.12);
  static final Color _darkFocusColor =
      const Color.fromARGB(255, 255, 255, 255).withOpacity(0.12);

  static ThemeData darkTheme = themeData(darkColorScheme, _darkFocusColor, Brightness.dark);

  static ThemeData lightTheme = themeData(lightColorScheme, _lightFocusColor, Brightness.light);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor, Brightness brightness) {
    return ThemeData(
      colorScheme: colorScheme,
      canvasColor: colorScheme.surface,
      scaffoldBackgroundColor: colorScheme.surface,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      useMaterial3: true,
      brightness: brightness,
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color.fromARGB(255, 24, 60, 129),
    secondary: Color.fromARGB(255, 234, 0, 255),
    surface: Color.fromARGB(255, 237, 240, 253),
    error: Color.fromARGB(255, 242, 17, 17),
    onPrimary: Color.fromARGB(255, 237, 240, 253),
    onSecondary: Color.fromARGB(255, 0, 255, 174),
    onSurface: Color.fromARGB(255, 9, 31, 72),
    onError: Color.fromARGB(255, 237, 240, 253),
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color.fromARGB(255, 237, 240, 253),
    secondary: Color.fromARGB(255, 234, 0, 255),
    surface: Color.fromARGB(255, 9, 31, 72),
    error: Color.fromARGB(255, 242, 17, 17),
    onPrimary: Color.fromARGB(255, 24, 60, 129),
    onSecondary: Color.fromARGB(255, 0, 255, 174),
    onSurface: Color.fromARGB(255, 237, 240, 253),
    onError: Color.fromARGB(255, 237, 240, 253),
    brightness: Brightness.dark,
  );
}