import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vecino_vigilante/configurations/routes_enum.dart';
import 'package:vecino_vigilante/utils/auth_utils.dart';

class PopupMenuAvatarButton extends StatelessWidget {
  final String username;

  const PopupMenuAvatarButton({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: CircleAvatar(
        backgroundImage: NetworkImage(
            "https://api.dicebear.com/7.x/micah/png?seed=$username"),
      ),
      onSelected: (value) {
        if (value == "logout") {
          context.go(RoutesEnum.login.path);
          AuthUtils.logout();
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        const PopupMenuItem(
          value: "logout",
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.logout),
              ),
              Text(
                'Cerrar sesión',
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
