import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  // ================= COLORS =================
  static const Color primaryColor = Color(0xFFFF6A00);
  static const Color backgroundColor = Color(0xFFC3C3C3);

  // ================= TEXT =================
  static TextStyle text({
    double size = 14,
    Color? color,
    FontWeight weight = FontWeight.w400,
    double height = 1.4,
  }) {
    return GoogleFonts.manrope(
      fontSize: size,
      color: color,
      fontWeight: weight,
      height: height,
    );
  }
}
