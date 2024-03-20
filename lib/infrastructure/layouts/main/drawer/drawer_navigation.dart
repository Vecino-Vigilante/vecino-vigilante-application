import 'package:flutter/material.dart';
import 'package:vecino_vigilante/infrastructure/layouts/main/drawer/drawer_footer.dart';
import 'package:vecino_vigilante/infrastructure/layouts/main/drawer/drawer_route.dart';
import 'package:vecino_vigilante/infrastructure/layouts/main/drawer/drawer_user_profile.dart';
import 'package:vecino_vigilante/infrastructure/pages/all_complaints_page.dart';
import 'package:vecino_vigilante/infrastructure/pages/crime_map_page.dart';
import 'package:vecino_vigilante/infrastructure/pages/emergency_numbers_page.dart';
import 'package:vecino_vigilante/infrastructure/pages/new_complaint_page.dart';

class DrawerNavigation extends StatelessWidget {
  const DrawerNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    List routes = [
      {
        "icon": Icons.home,
        "label": "Inicio",
        "destination": const AllComplaintsPage()
      },
      {
        "icon": Icons.location_city,
        "label": "Mapa delictivo",
        "destination": const CrimeMapPage()
      },
      {
        "icon": Icons.add_comment_rounded,
        "label": "Nueva denuncia",
        "destination": const NewComplaintPage()
      },
      {
        "icon": Icons.local_police,
        "label": "Números de emergencia",
        "destination": const EmergencyNumbersPage()
      }
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
                    destination: route["destination"],
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
