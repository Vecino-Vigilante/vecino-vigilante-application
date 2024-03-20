import 'package:flutter/material.dart';

class DrawerRoute extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget destination;

  const DrawerRoute(
      {super.key,
      required this.icon,
      required this.label,
      required this.destination});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => destination));
      },
    );
  }
}
