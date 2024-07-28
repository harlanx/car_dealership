import 'package:flutter/material.dart';
import 'package:function_helpers/function_helpers.dart';

export 'car_highlights.dart';
export 'car_lineup.dart';
export 'news_headlines.dart';

class AppData {
  static String selectedLocale = 'en';

  static double maxWidthConstraints = 1280.0;

  static Color color = const Color(0xffc22610);
  static final MaterialColor colorSwatch = MaterialColor(0xffc22610, {
    50: const Color(0xffc22610).brighten(0.5),
    100: const Color(0xffc22610).brighten(0.4),
    200: const Color(0xffc22610).brighten(0.3),
    300: const Color(0xffc22610).brighten(0.2),
    400: const Color(0xffc22610).brighten(0.1),
    500: const Color(0xffc22610),
    600: const Color(0xffc22610).darken(0.1),
    700: const Color(0xffc22610).darken(0.2),
    800: const Color(0xffc22610).darken(0.3),
    900: const Color(0xffc22610).darken(0.4),
  });

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'Lato',
      primarySwatch: colorSwatch,
      textSelectionTheme:
          const TextSelectionThemeData(selectionColor: Colors.blue),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.white,
        hoverColor: Colors.orange,
        focusColor: Colors.yellow,
        highlightColor: Colors.blue,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'Lato',
      primarySwatch: colorSwatch,
      textSelectionTheme:
          const TextSelectionThemeData(selectionColor: Colors.blue),
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.black,
        hoverColor: Colors.teal,
        focusColor: Colors.green,
        highlightColor: Colors.purple,
      ),
    );
  }
}
