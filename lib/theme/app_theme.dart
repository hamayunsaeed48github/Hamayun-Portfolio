import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const ink          = Color(0xFF0C0E14);
  static const surface      = Color(0xFF13161E);
  static const surfaceCard  = Color(0xFF191D27);
  static const surfaceLight = Color(0xFF222633);
  static const border       = Color(0xFF2A2F3E);
  static const sand         = Color(0xFFCDA876);
  static const sandLight    = Color(0xFFE8CC96);
  static const teal         = Color(0xFF5BBFC8);
  static const tealDark     = Color(0xFF3A8A92);
  static const paper        = Color(0xFFECE8E1);
  static const mist         = Color(0xFF6E7285);
  static const mistLight    = Color(0xFF9DA1B0);
  static const success      = Color(0xFF5DBF8A);
  static const warning      = Color(0xFFD4944A);
}

class AppText {
  static TextStyle display = GoogleFonts.sora(
    color: AppColors.paper, fontWeight: FontWeight.w800,
    height: 1.05, letterSpacing: -2.5,
  );
  static TextStyle h2 = GoogleFonts.sora(
    color: AppColors.paper, fontWeight: FontWeight.w700,
    fontSize: 38, letterSpacing: -1.0, height: 1.12,
  );
  static TextStyle h3 = GoogleFonts.sora(
    color: AppColors.paper, fontWeight: FontWeight.w700,
    fontSize: 22, height: 1.2, letterSpacing: -0.4,
  );
  static TextStyle h4 = GoogleFonts.sora(
    color: AppColors.paper, fontWeight: FontWeight.w600,
    fontSize: 17, height: 1.3,
  );
  static TextStyle body = GoogleFonts.manrope(
    color: AppColors.mist, fontSize: 15.5, height: 1.78,
  );
  static TextStyle bodyStrong = GoogleFonts.manrope(
    color: AppColors.paper, fontSize: 15.5,
    fontWeight: FontWeight.w600, height: 1.6,
  );
  static TextStyle small = GoogleFonts.manrope(
    color: AppColors.mistLight, fontSize: 13, height: 1.55,
  );
  static TextStyle mono = GoogleFonts.spaceMono(
    color: AppColors.teal, fontSize: 11.5,
    letterSpacing: 3.5, fontWeight: FontWeight.w700,
  );
  static TextStyle button = GoogleFonts.manrope(
    fontWeight: FontWeight.w700, fontSize: 14.5, letterSpacing: 0.3,
  );
}

const double kBreakpoint = 880.0;
