import 'package:flutter/material.dart';

class Navbar {
  static PreferredSizeWidget render(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return AppBar(
      centerTitle: true,
      title: const Text("Vecino Vigilante"),
      backgroundColor: theme.primaryColor,
      foregroundColor: theme.colorScheme.onPrimary,
    );
  }
}
