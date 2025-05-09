import 'package:easy_localization/easy_localization.dart';

/// A helper class to format `DateTime` values into localized strings.
///
/// This utility adapts date and time formatting based on the current language,
/// and provides readable representations for time differences and event start info.
class DateFormatHelper {

  /// Returns a localized long date string (e.g. "12/31/2025" or "31/12/2025").
  static String longDateStr(DateTime date) {
    final languageCode = Intl.getCurrentLocale();
    if (languageCode == 'en') {
      return DateFormat('MM/dd/yyyy').format(date);
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }

  /// Returns a localized short date string (e.g. "12/31" or "31/12").
  static String shortDateStr(DateTime date) {
    final languageCode = tr('language');
    if (languageCode == 'en') {
      return DateFormat('MM/dd').format(date);
    } else {
      return DateFormat('dd/MM').format(date);
    }
  }

  /// Returns a string describing the duration between [begin] and [end].
  ///
  /// Examples:
  /// - "3d" (3 days)
  /// - "5h 30m" (5 hours, 30 minutes)
  /// - "45m" (only minutes)
  static String timeLapseStr(DateTime begin, DateTime end) {
    final days = end.difference(begin).inDays;
    final hours = (end.difference(begin).inMinutes / 60).truncate();
    final minutes = end.difference(begin).inMinutes % 60;

    if (days > 0) {
      return '${days}d';
    } else if (hours == 0) {
      return '${minutes}m';
    } else if (minutes == 0) {
      return '${hours}h';
    } else {
      return '${hours}h ${minutes}m';
    }
  }

  /// Returns a localized string indicating how soon an event starts based on [beginAt].
  ///
  /// Examples:
  /// - "Today"
  /// - "Tomorrow"
  /// - "In 3 days"
  static String timeToStartStr(DateTime beginAt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final eventDay = DateTime(beginAt.year, beginAt.month, beginAt.day);

    final diffDays = eventDay.difference(today).inDays;

    if (diffDays == 0) {
      return tr('home.events.today');
    } else if (diffDays == 1) {
      return tr('home.events.tomorrow');
    } else {
      return '${tr('home.events.in')} $diffDays ${tr('home.events.days')}';
    }
  }
}
