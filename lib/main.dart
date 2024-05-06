import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:vecino_vigilante/states/complaints_state.dart';
import 'package:vecino_vigilante/vecino_vigilante_application.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await initializeDateFormatting('es-MX');

  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => ComplaintsState())],
    child: const VecinoVigilanteApplication(),
  ));
}
