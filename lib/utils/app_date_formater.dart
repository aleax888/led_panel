import 'package:intl/intl.dart';
import 'package:led_panel/l10n/app_localizations.dart';

/// A utility class for formatting dates in various localized styles.
class AppDateFormater {
  AppDateFormater._();

  static String _formatDate(
    DateTime? date,
    String pattern,
    AppLocalizations l10n, {
    bool dateOnly = false,
  }) {
    if (date == null) {
      return l10n.noDateAvailable;
    }

    final DateTime now = DateTime.now();
    final Duration difference = now.difference(date);
    final Duration absDifference = difference.isNegative
        ? -difference
        : difference;

    if (absDifference <= const Duration(minutes: 1)) {
      return l10n.rightNow;
    }

    if (dateOnly) {
      final DateTime todayCalendar = DateTime(now.year, now.month, now.day);
      final DateTime targetCalendar = DateTime(date.year, date.month, date.day);
      final int dayDifference = targetCalendar.difference(todayCalendar).inDays;

      if (dayDifference == 0) {
        return l10n.today;
      }

      if (dayDifference == -1) {
        return l10n.yesterday;
      }

      if (dayDifference == 1) {
        return l10n.tomorrow;
      }
    }

    return DateFormat(pattern, l10n.localeName).format(date);
  }

  static String compact(DateTime? date, AppLocalizations l10n) {
    return _formatDate(date, 'dd/MM/yyyy', l10n, dateOnly: true);
  }

  static String long(DateTime? date, AppLocalizations l10n) {
    return _formatDate(date, 'EEEE, d MMMM y', l10n, dateOnly: true);
  }

  static String full(DateTime? date, AppLocalizations l10n) {
    return _formatDate(date, 'dd MMMM yyyy HH:mm', l10n);
  }

  static String shortTime(DateTime? date, AppLocalizations l10n) {
    return _formatDate(date, 'HH:mm', l10n);
  }

  static String database(DateTime? date, AppLocalizations l10n) {
    return _formatDate(date, 'yyyy-MM-dd', l10n, dateOnly: true);
  }

  static String monthYear(DateTime? date, AppLocalizations l10n) {
    return _formatDate(date, 'MMMM yyyy', l10n);
  }

  static String weekday(DateTime? date, AppLocalizations l10n) {
    return _formatDate(date, 'EEEE', l10n);
  }
}
