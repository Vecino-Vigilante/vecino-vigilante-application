import 'package:flutter/material.dart';
import 'package:vecino_vigilante/infrastructure/pages/all_complaints_page.dart';

class VecinoVigilanteApplication extends StatelessWidget {
  const VecinoVigilanteApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const AllComplaintsPage(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(75, 123, 236, 1)),
        useMaterial3: true,
      ),
      title: "Vecino Vigilante",
    );
  }
}
