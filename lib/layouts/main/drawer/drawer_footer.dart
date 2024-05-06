import 'package:flutter/material.dart';
import 'package:vecino_vigilante/utils/launch_urls_utils.dart';

class DrawerFooter extends StatelessWidget {
  const DrawerFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListTile(
        leading: const Icon(Icons.phone),
        title: const Text("¿Es una emergencia?"),
        subtitle: const Text("Llama a las autoridades"),
        onTap: () => makePhoneCall("911"),
      ),
    );
  }
}
