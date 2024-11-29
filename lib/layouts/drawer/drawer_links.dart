import 'package:flutter/material.dart';
import 'package:vecino_vigilante/configurations/routes_enum.dart';
import 'package:vecino_vigilante/layouts/drawer/drawer_footer.dart';
import 'package:vecino_vigilante/layouts/drawer/drawer_route.dart';
import 'package:vecino_vigilante/layouts/drawer/drawer_user_profile.dart';

class DrawerLinks extends StatelessWidget {
  const DrawerLinks({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List routes = [
      {
        "icon": Icons.home,
        "label": RoutesEnum.home.name,
        "path": RoutesEnum.home.path
      },
      {
        "icon": Icons.add_comment_rounded,
        "label": RoutesEnum.newComplaint.name,
        "path": RoutesEnum.newComplaint.path
      },
      {
        "icon": Icons.location_city,
        "label": RoutesEnum.crimeMap.name,
        "path": RoutesEnum.crimeMap.path
      },
    ];

    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                const DrawerUserProfile(),
                ...routes.map(
                  (route) => DrawerRoute(
                    icon: route["icon"],
                    label: route["label"],
                    path: route["path"],
                  ),
                ),
              ],
            ),
          ),
          const DrawerFooter()
        ],
      ),
    );
  }
}
