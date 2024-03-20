import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vecino_vigilante/infrastructure/states/reports_state.dart';
import 'package:vecino_vigilante/vecino_vigilante_application.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => ReportsState())],
    child: const VecinoVigilanteApplication(),
  ));
}
