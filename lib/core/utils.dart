import 'package:intl/intl.dart';

bool isNumeric(String? s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

String toRM(dynamic number, {bool? rm, bool decimal = false}) {
  final formatter = !decimal ? NumberFormat('#,##0', 'en_US') : NumberFormat('#,##0.00', 'en_US');
  if (!(number is int || number is double)) {
    if (isNumeric(number)) {
      number = double.parse(number);
    }
  }
  if (number is int || number is double) {
    if (rm != null && rm) return 'RM ${formatter.format(number)}';
    return formatter.format(number);
  } else {
    if (rm != null && rm) return 'RM $number';
    return number == null || number.isEmpty ? '' : formatter.format(number);
  }
}