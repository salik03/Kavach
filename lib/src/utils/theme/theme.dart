import 'package:flutter/material.dart';
import 'package:kavach_2/src/utils/theme/widget_themes/text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: const MaterialColor(0xFFFFFFFF, <int, Color>{
      50: Color(0xFFE6F9F6),
      100: Color(0xFFDDF1E9),
      200: Color(0xFFA7F3D0),
      300: Color(0xFF6EE7B7),
      400: Color(0xFF10B981),
      500: Color(0xFF008357),
      600: Color(0xFF1D4D4F),
      700: Color(0xFF000000),
    }),
    textTheme: TtextTheme.lightTextTheme,
  );
  // static ThemeData darkTheme = ThemeData(
  //     brightness: Brightness.dark, textTheme: TtextTheme.darkTextTheme);
}
