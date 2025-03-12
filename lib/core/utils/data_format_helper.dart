import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';

class DataFormatHelper {

  static String longFormatDate(DateTime date) {
    final languageCode = Intl.getCurrentLocale();
    if (languageCode == 'en') {
      return DateFormat('MM/dd/yyyy').format(date);
    } else {
      // Formato para otros idiomas: día/mes/año
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }

  static String shortFormatDate(DateTime date) {
    final languageCode = tr('language');
    if (languageCode == 'en') {
      return DateFormat('MM/dd').format(date);
    } else {
      // Formato para otros idiomas: día/mes
      return DateFormat('dd/MM').format(date);
    }
  }
}