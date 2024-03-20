import 'package:flutter/material.dart';
import 'package:vecino_vigilante/infrastructure/layouts/main/main_layout.dart';

class AllComplaintsPage extends StatelessWidget {
  const AllComplaintsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainLayout(
      body: Text("Todos los reportes"),
    );
  }
}
