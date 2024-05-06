import 'package:intl/intl.dart';

String getSpanishDateFormat(DateTime fecha) {
  DateFormat formatter = DateFormat("dd 'de' MMMM 'del' yyyy", 'es-MX');
  return formatter.format(fecha);
}