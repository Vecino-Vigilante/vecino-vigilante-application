import 'package:flutter/material.dart';
import 'package:vecino_vigilante/layouts/app_bar.dart';
import 'package:vecino_vigilante/layouts/drawer/drawer_links.dart';

class MainLayout extends StatelessWidget {
  final Widget body;
  final Widget? floatingActionButton;

  const MainLayout({
    super.key,
    required this.body,
    required this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar.render(context),
      drawer: const DrawerLinks(),
      resizeToAvoidBottomInset: false,
      floatingActionButton: floatingActionButton,
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
