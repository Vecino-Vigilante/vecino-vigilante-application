import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DrawerRoute extends StatelessWidget {
  final IconData icon;
  final String label;
  final String path;

  const DrawerRoute({
    super.key,
    required this.icon,
    required this.label,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () {
        context.go(path);
        Navigator.pop(context);
      },
    );
  }
}
