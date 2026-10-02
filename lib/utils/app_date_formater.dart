import 'package:intl/intl.dart';

/// A utility class for formatting dates in various styles.
class AppDateFormater {
  AppDateFormater._();

  static const String _nullFeedback = 'No date available';
  static const String _rightNowFeedback = 'Right now';

  static final DateFormat _compactFormat = DateFormat('dd/MM/yyyy');
  static final DateFormat _longFormat = DateFormat('EEEE, d MMMM y', 'es');
  static final DateFormat _fullFormat = DateFormat('dd MMMM yyyy HH:mm', 'es');
  static final DateFormat _shortTimeFormat = DateFormat('HH:mm');
  static final DateFormat _dbFormat = DateFormat('yyyy-MM-dd');
  static final DateFormat _monthYearFormat = DateFormat('MMMM yyyy', 'es');
  static final DateFormat _weekdayFormat = DateFormat('EEEE', 'es');

  static String _formatDate(
    DateTime? date,
    DateFormat formatter, {
    bool dateOnly = false,
  }) {
    if (date == null) {
      return _nullFeedback;
    }

    final DateTime now = DateTime.now();
    final Duration difference = now.difference(date);
    final Duration absDifference = difference.isNegative
        ? -difference
        : difference;

    if (absDifference <= const Duration(minutes: 1)) {
      return _rightNowFeedback;
    }

    if (dateOnly) {
      final DateTime todayCalendar = DateTime(now.year, now.month, now.day);
      final DateTime targetCalendar = DateTime(date.year, date.month, date.day);
      final int dayDifference = targetCalendar.difference(todayCalendar).inDays;

      if (dayDifference == 0) {
        return 'Today';
      }

      if (dayDifference == -1) {
        return 'Yesterday';
      }

      if (dayDifference == 1) {
        return 'Tomorrow';
      }
    }

    return formatter.format(date);
  }

  static String compact(DateTime? date) {
    return _formatDate(date, _compactFormat, dateOnly: true);
  }

  static String long(DateTime? date) {
    return _formatDate(date, _longFormat, dateOnly: true);
  }

  static String full(DateTime? date) {
    return _formatDate(date, _fullFormat);
  }

  static String shortTime(DateTime? date) {
    return _formatDate(date, _shortTimeFormat);
  }

  static String database(DateTime? date) {
    return _formatDate(date, _dbFormat, dateOnly: true);
  }

  static String monthYear(DateTime? date) {
    return _formatDate(date, _monthYearFormat);
  }

  static String weekday(DateTime? date) {
    return _formatDate(date, _weekdayFormat);
  }
}
