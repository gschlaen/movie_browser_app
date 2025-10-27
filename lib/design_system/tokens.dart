import 'package:flutter/material.dart';

// --- BRAND TOKENS ---
// These are the raw, non-semantic values for the brand.
// They should not be used directly in the UI.
// They are consumed by the App Foundations.

/// Defines the brand's core color palette.
abstract class BrandColors {
  // Brand Primary
  static const Color red500 = Color(0xFFD93B4A);

  static const Color red800 = Color.fromRGBO(217, 49, 74, 0.18);

  // Inactive/disabled
  static const Color light300 = Color.fromARGB(255, 212, 141, 141);

  // Neutrals (Dark Theme)
  static const Color dark100 = Color(0xFF2B1B1B); // Deepest background
  static const Color dark200 = Color(0xFF2F2323); // Surface background

  // Neutrals (Light/Content)
  static const Color light100 = Color(0xFFFFFFFF); // Primary content
  static const Color light200 = Color(0xFF92929D); // Hint/placeholder

  // Semantic Palette
  static const Color yellow500 = Color(0xFFFFC107); // Ratings, warnings, etc.
  static const Color yellow300 = Color.fromARGB(255, 163, 126, 16);
}

/// Defines the brand's spacing scale.
abstract class BrandSpacing {
  static const double scale4 = 4.0;
  static const double scale8 = 8.0;
  static const double scale12 = 12.0;
  static const double scale16 = 16.0;
  static const double scale20 = 20.0;
  static const double scale24 = 24.0;
}

/// Defines the brand's typographic scale (raw values).
abstract class BrandFonts {
  /// Assumed sans-serif font family.
  static const String familySans = 'Inter';

  // Font Sizes
  static const double size12 = 12.0;
  static const double size14 = 14.0;
  static const double size16 = 16.0;
  static const double size22 = 22.0;

  // Font Weights
  static const FontWeight weightRegular = FontWeight.w400;
  static const FontWeight weightMedium = FontWeight.w500;
  static const FontWeight weightBold = FontWeight.w700;
}
