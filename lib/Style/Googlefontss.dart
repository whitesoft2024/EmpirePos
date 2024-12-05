import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Googlefonts {
  static TextStyle exo2({
    double? fontSize,
    FontWeight? fontWeight ,
  }) {
    return GoogleFonts.exo2(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }

  static TextStyle lato({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }

  static TextStyle openSans({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return GoogleFonts.openSans(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }

// Add more styles as needed with adjustable font sizes and font weights
}
