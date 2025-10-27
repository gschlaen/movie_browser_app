import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

/// A utility class to format vote counts or other large numbers
/// into a compact, human-readable string using the 'intl' package.
class VoteCountFormatter {
  // A static formatter for efficiency. Reusing the formatter is much
  // faster than creating a new one for every call.
  // The 'en_US' locale uses '.' as the decimal separator (e.g., "1.3k").
  static final _compactFormatter = NumberFormat.compact(locale: 'en_US')
    ..maximumFractionDigits = 1
    ..significantDigitsInUse = false;

  /// Formats a numeric value like:
  ///  - 532 → "532"
  ///  - 532.4 → "532.4" (special rule from original code)
  ///  - 1,250 → "1.3k"
  ///  - 1,250,000 → "1.3m"
  ///
  /// This implementation uses [NumberFormat.compact] for robust formatting
  /// and scalability (e.g., to "B" for billions).
  String format(num value) {
    // EXCEPTION: Handle the original rule for decimals < 1000.
    // NumberFormat.compact(532.4) would otherwise round to "532".
    // We preserve the decimal if it exists and is not .0.
    if (value < 1000 && value is double && value != value.roundToDouble()) {
      return value.toStringAsFixed(1);
    }

    // For all other cases (integers < 1000 and all numbers >= 1000),
    // use the intl compact formatter.
    final formatted = _compactFormatter.format(value);

    // Convert to lowercase ("1.3K" -> "1.3k", "1.3M" -> "1.3m")
    // to match the original requirement.
    return formatted.toLowerCase();
  }
}

/// Global provider for formatting numeric values
/// (e.g. view counts, followers, ratings, etc.)
final voteCountProvider = Provider<VoteCountFormatter>((ref) {
  return VoteCountFormatter();
});
