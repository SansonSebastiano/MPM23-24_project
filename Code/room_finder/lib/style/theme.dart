import 'package:flutter/material.dart';

import 'package:room_finder/style/color_palette.dart';

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
    primary: ColorPalette.darkConflowerBlue,
    secondary: Color.fromARGB(255, 234, 0, 255),
    surface: ColorPalette.aliceBlue,
    error: Color.fromARGB(255, 242, 17, 17),
    onPrimary: ColorPalette.aliceBlue,
    onSecondary: Color.fromARGB(255, 0, 255, 174),
    onSurface: ColorPalette.oxfordBlue,
    onError: ColorPalette.aliceBlue,
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: ColorPalette.aliceBlue,
    secondary: Color.fromARGB(255, 234, 0, 255),
    surface: ColorPalette.oxfordBlue,
    error: Color.fromARGB(255, 242, 17, 17),
    onPrimary: ColorPalette.darkConflowerBlue,
    onSecondary: Color.fromARGB(255, 0, 255, 174),
    onSurface: ColorPalette.aliceBlue,
    onError: ColorPalette.aliceBlue,
    brightness: Brightness.dark,
  );
}