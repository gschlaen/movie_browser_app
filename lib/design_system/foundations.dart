import 'package:flutter/material.dart';
import 'package:movie_browser_app/design_system/tokens.dart';

// --- APP FOUNDATIONS ---
// These are the semantic, app-specific tokens.
// They consume the Brand Tokens and give them meaning.
// Your UI code should ONLY use these foundations.

/// Semantic color definitions for the application.
abstract class AppColors {
  // Background Colors
  /// The main app background color.
  static const Color background = BrandColors.dark100;

  /// The color for surfaces "on top" of the background (e.g., cards, nav bars).
  static const Color surface = BrandColors.dark200;

  // Content Colors
  /// The default color for text and icons on 'background'.
  static const Color onBackground = BrandColors.light100;

  /// The default color for text and icons on 'surface'.
  static const Color onSurface = BrandColors.light100;

  /// The color for less-prominent content (e.g., hint text).
  static const Color onSurfaceVariant = BrandColors.light200;

  // Interactive Colors
  /// The primary interactive color (e.g., active nav icon).
  static const Color primary = BrandColors.red500;

  // Semantic Colors
  /// The color used for star ratings.
  static const Color rating = BrandColors.yellow500;
  static const Color ratingText = BrandColors.yellow300;

  /// The color for inactive interactive elements.
  static const Color inactive = BrandColors.light300;

  /// The color for chip background.
  static const Color chipBackground = BrandColors.red800;

  /// The color for chip text.
  static const Color chipText = BrandColors.red500;

  /// The color for star ratings in MovieDetailScreen.
  static const Color star = BrandColors.red500;
}

/// Semantic spacing definitions for layout and components.
abstract class AppSpacing {
  /// Smallest gap (e.g., between icon and text).
  static const double xs = BrandSpacing.scale4;

  /// Small gap (e.g., inner padding).
  static const double s = BrandSpacing.scale8;

  /// Medium gap (e.g., between cards).
  static const double m = BrandSpacing.scale12;

  /// Medium gap (e.g., between cards).
  static const double l = BrandSpacing.scale16;

  /// Horizontal padding for a page container.
  static const double pageHorizontal = BrandSpacing.scale20;

  /// Vertical padding for a page container.
  static const double pageVertical = BrandSpacing.scale24;
}

/// Semantic text style definitions for the application.
abstract class AppTypography {
  /// Base style, useful for `copyWith`.
  static const TextStyle _base = TextStyle(
    fontFamily: BrandFonts.familySans,
    color: AppColors.onBackground, // Default text color
  );

  /// For main page titles (e.g., "Popular Movies").
  static final TextStyle headlineMedium = _base.copyWith(
    fontSize: BrandFonts.size22,
    fontWeight: BrandFonts.weightBold,
  );

  /// For component titles (e.g., movie card titles).
  static final TextStyle titleMedium = _base.copyWith(
    fontSize: BrandFonts.size16,
    fontWeight: BrandFonts.weightBold,
  );

  /// For standard body text (e.g., search placeholder).
  static final TextStyle bodyLarge = _base.copyWith(
    fontSize: BrandFonts.size14,
    fontWeight: BrandFonts.weightRegular,
  );

  /// For chip text.
  static final TextStyle labelMedium = _base.copyWith(
    fontSize: BrandFonts.size14,
    fontWeight: BrandFonts.weightMedium,
  );

  /// For small supporting text (e.g., rating number).
  static final TextStyle bodySmall = _base.copyWith(
    fontSize: BrandFonts.size12,
    fontWeight: BrandFonts.weightRegular,
  );

  /// For navigation bar labels.
  static final TextStyle labelSmall = _base.copyWith(
    fontSize: BrandFonts.size12,
    fontWeight: BrandFonts.weightMedium,
  );
}
