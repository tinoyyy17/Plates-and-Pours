import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Palette sampled directly from the Plates & Pours logo, applied with the
/// 60-30-10 rule:
///   60% — warm cream page backdrop + white card surface (the neutral bulk)
///   30% — forest green: headings, nav elements, structural text
///   10% — gold: buttons and the few things that should draw the eye
class AppColors {
  static const pageBg = Color(0xFFF3EEDF); // 60% — backdrop behind the card
  static const white = Color(0xFFFFFFFF); // 60% — the menu "card" surface
  static const cardBg = Color(0xFFFAF6EA); // 60% family — item row tint
  static const forest = Color(0xFF1C3B22); // 30% — headings, nav, structure
  static const forestMuted = Color(0xFF5F6F61); // 30% family, lighter tint
  static const gold = Color(0xFFE4A73D); // 10% — accent only
  static const border = Color(0xFFE7E2D3); // neutral hairline
}

ThemeData buildAppTheme() {
  final base = ThemeData(useMaterial3: true, brightness: Brightness.light);
  return base.copyWith(
    scaffoldBackgroundColor: AppColors.pageBg,
    colorScheme: base.colorScheme.copyWith(
      primary: AppColors.gold,
      onPrimary: AppColors.forest,
      surface: AppColors.cardBg,
    ),
    dividerColor: AppColors.border,
    textTheme: TextTheme(
      displaySmall: GoogleFonts.fraunces(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.forest,
        height: 1.1,
      ),
      titleMedium: GoogleFonts.fraunces(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppColors.forest,
      ),
      bodyLarge: GoogleFonts.workSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.forest,
      ),
      bodyMedium: GoogleFonts.workSans(
        fontSize: 13.5,
        color: AppColors.forest,
        height: 1.4,
      ),
      bodySmall: GoogleFonts.workSans(
        fontSize: 12,
        color: AppColors.forestMuted,
      ),
      labelLarge: GoogleFonts.workSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.forest,
      ),
    ),
  );
}
