import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:room_finder/style/color_palette.dart';

/// A class that contains the global theme data used in the app.
///
/// This class contains the [lightTheme] and [darkTheme] themes used in the app, as well as the color schemes ([lightColorScheme] and [darkColorScheme]) for each theme.
/// The light and dark themes changes according to the system preference.
class GlobalThemeData {
  static final Color _lightFocusColor =
      const Color.fromARGB(255, 0, 0, 0).withOpacity(0.12);
  static final Color _darkFocusColor =
      const Color.fromARGB(255, 255, 255, 255).withOpacity(0.12);

  static ThemeData darkTheme =
      themeData(darkColorScheme, _darkFocusColor, Brightness.dark);

  static ThemeData lightTheme =
      themeData(lightColorScheme, _lightFocusColor, Brightness.light);

  static ThemeData themeData(
      ColorScheme colorScheme, Color focusColor, Brightness brightness) {
    return ThemeData(
      colorScheme: colorScheme,
      canvasColor: colorScheme.surface,
      scaffoldBackgroundColor: colorScheme.surface,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      useMaterial3: true,
      brightness: brightness,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontSize: 400,
            fontWeight: FontWeight.bold,
            color: ColorPalette.darkConflowerBlue),
        displayMedium: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: ColorPalette.darkConflowerBlue),
        displaySmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ColorPalette.darkConflowerBlue),
        bodyLarge:
            TextStyle(fontSize: 20, color: ColorPalette.darkConflowerBlue),
        bodyMedium:
            TextStyle(fontSize: 16, color: ColorPalette.darkConflowerBlue),
        bodySmall:
            TextStyle(fontSize: 12, color: ColorPalette.darkConflowerBlue),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: ColorPalette.darkConflowerBlue,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.all(
          const IconThemeData(color: ColorPalette.aliceBlue),
        ),
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(
            color: ColorPalette.aliceBlue,
          ),
        ),
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: colorScheme.primary,
        primaryContrastingColor: colorScheme.onPrimary,
        scaffoldBackgroundColor: colorScheme.surface,
        applyThemeToAll: true,
        brightness: brightness,
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            color: colorScheme.primary,
          ),
          actionTextStyle: TextStyle(
            color: colorScheme.primary,
          ),
        ),
      ),
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: ColorPalette.darkConflowerBlue,
    secondary: ColorPalette.jordyBlue,
    surface: ColorPalette.aliceBlue,
    error: Color.fromARGB(255, 255, 55, 55),
    onPrimary: ColorPalette.aliceBlue,
    onSecondary: ColorPalette.aliceBlue,
    onSurface: ColorPalette.oxfordBlue,
    onError: ColorPalette.aliceBlue,
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: ColorPalette.aliceBlue,
    secondary: ColorPalette.jordyBlue,
    surface: ColorPalette.oxfordBlue,
    error: Color.fromARGB(255, 242, 17, 17),
    onPrimary: ColorPalette.darkConflowerBlue,
    onSecondary: ColorPalette.aliceBlue,
    onSurface: ColorPalette.aliceBlue,
    onError: ColorPalette.aliceBlue,
    brightness: Brightness.dark,
  );
}
