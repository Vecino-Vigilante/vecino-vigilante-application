import 'package:intl/intl.dart';

String getSpanishDateFormat(DateTime fecha) {
  DateFormat formatter = DateFormat("dd 'de' MMMM 'del' yyyy, HH:mm", 'es-MX');
  return formatter.format(fecha);
}