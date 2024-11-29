import 'package:flutter/material.dart';
import 'package:vecino_vigilante/dto/authenticated_user_dto.dart';
import 'package:vecino_vigilante/utils/auth_utils.dart';
import 'package:vecino_vigilante/widgets/circle_avatar_with_menu.dart';

class DrawerUserProfile extends StatelessWidget {
  const DrawerUserProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AuthenticatedUserDTO?>(
      future: AuthUtils.getAuthenticatedUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String userFullName =
              "${snapshot.data?.userName} ${snapshot.data?.userLastName}";

          return UserAccountsDrawerHeader(
            accountName: Text(userFullName),
            accountEmail: Text(snapshot.data?.userEmail ?? ""),
            currentAccountPicture: CircleAvatarWithMenu(
              username: userFullName,
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text(
              "¡Oh, no! Se produjo un error al intentar obtener los datos de tu cuenta.",
              textAlign: TextAlign.center,
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
