import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TtextTheme {
  static TextTheme lightTextTheme = TextTheme(
    headline2: GoogleFonts.roboto(
      color: Colors.black87,
    ),
    subtitle2: GoogleFonts.roboto(
      color: Colors.black54,
      fontSize: 14,
    ),
  );
  static TextTheme darkTextTheme = TextTheme(
    headline2: GoogleFonts.roboto(
      color: Colors.white70,
    ),
    subtitle2: GoogleFonts.roboto(
      color: Colors.white60,
      fontSize: 14,
    ),
  );
}
