import 'package:flutter/material.dart';
import 'package:vecino_vigilante/http/responses/authenticated_user_response.dart';
import 'package:vecino_vigilante/utils/auth_utils.dart';
import 'package:vecino_vigilante/widgets/popup_menu_avatar_button.dart';

class DrawerUserProfile extends StatelessWidget {
  const DrawerUserProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AuthenticatedUserResponseDTO?>(
      future: AuthUtils.getAuthenticatedUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String userFullName =
              "${snapshot.data?.userName} ${snapshot.data?.userLastName}";

          return UserAccountsDrawerHeader(
            accountName: Text(userFullName),
            accountEmail: Text(snapshot.data?.userEmail ?? ""),
            currentAccountPicture: PopupMenuAvatarButton(
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
