import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  // Títulos
  static final title = GoogleFonts.montserrat(
    textStyle: const TextStyle(fontSize: 32, color: Color(0xFF333333)),
  );

  // Subtítulos
  static final subtitle = GoogleFonts.montserrat(
    textStyle: const TextStyle(fontSize: 20, color: Color(0xFF333333)),
  );

  // Texto normal
  static final text = GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontSize: 18,
      color: Color(0xFF333333),
      fontWeight: FontWeight.w300,
    ),
  );

  // Botones
  static final button = GoogleFonts.robotoCondensed(
    textStyle: const TextStyle(
      fontSize: 16,
      color: Color(0xFF333333),
      fontWeight: FontWeight.w500,
    ),
  );
}
