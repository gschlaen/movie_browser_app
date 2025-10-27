import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DateFormatter {
  String format(String isoDate, {String locale = 'en_US'}) {
    try {
      final date = DateTime.parse(isoDate);
      return DateFormat('MMM d, y', locale).format(date);
    } catch (_) {
      return isoDate;
    }
  }
}

final dateFormatterProvider = Provider<DateFormatter>((ref) {
  return DateFormatter();
});
