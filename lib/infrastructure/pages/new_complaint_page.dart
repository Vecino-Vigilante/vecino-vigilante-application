import 'package:flutter/material.dart';
import 'package:vecino_vigilante/infrastructure/layouts/main/main_layout.dart';

class NewComplaintPage extends StatelessWidget {
  const NewComplaintPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainLayout(body: Text("Nueva denuncia"));
  }
}
