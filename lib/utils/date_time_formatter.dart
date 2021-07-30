import 'package:intl/intl.dart';

class MyDateTime {
  String formateDate(date) {
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(DateTime.parse(date));
    return formattedDate;
  }
}
