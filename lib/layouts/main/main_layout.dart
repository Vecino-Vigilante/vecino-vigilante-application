import 'package:flutter/material.dart';
import 'package:vecino_vigilante/layouts/main/app_bar.dart';
import 'package:vecino_vigilante/layouts/main/drawer/drawer_navigation.dart';

class MainLayout extends StatelessWidget {
  final Widget body;

  const MainLayout({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar.render(context),
      drawer: const DrawerNavigation(),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 17,
            vertical: 31,
          ),
          child: body,
        ),
      ),
    );
  }
}
