import 'package:flutter/material.dart';

class DrawerUserProfile extends StatelessWidget {
  const DrawerUserProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const UserAccountsDrawerHeader(
      accountName: Text("Abraham Espinosa Mendoza"),
      accountEmail: Text("abraham_espinosa@icloud.com"),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(
            "https://api.dicebear.com/7.x/micah/png?seed=Abraham%20Espinosa%20Mendoza"),
      ),
    );
  }
}
