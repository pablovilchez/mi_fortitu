import 'package:easy_localization/easy_localization.dart';

class DateFormatHelper {
  static String longDateStr(DateTime date) {
    final languageCode = Intl.getCurrentLocale();
    if (languageCode == 'en') {
      return DateFormat('MM/dd/yyyy').format(date);
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }

  static String shortDateStr(DateTime date) {
    final languageCode = tr('language');
    if (languageCode == 'en') {
      return DateFormat('MM/dd').format(date);
    } else {
      return DateFormat('dd/MM').format(date);
    }
  }

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
