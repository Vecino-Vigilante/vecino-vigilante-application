import 'package:flutter/material.dart';
import 'package:vecino_vigilante/layouts/main/main_layout.dart';

class ComplaintPage extends StatelessWidget {
  final String? complaintId;

  const ComplaintPage({
    super.key,
    required this.complaintId,
  });

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      body: Text("$complaintId"),
    );
  }
}
