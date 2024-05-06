import 'package:flutter/material.dart';
import 'package:vecino_vigilante/layouts/main/main_layout.dart';

class CrimeMapPage extends StatelessWidget {
  const CrimeMapPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MainLayout(
      body: Text("Mapa delictivo"),
    );
  }
}
