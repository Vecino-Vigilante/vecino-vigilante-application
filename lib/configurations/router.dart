import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vecino_vigilante/configurations/routes_enum.dart';
import 'package:vecino_vigilante/pages/all_complaints_page.dart';
import 'package:vecino_vigilante/pages/complaint_page.dart';
import 'package:vecino_vigilante/pages/crime_map_page.dart';
import 'package:vecino_vigilante/pages/emergency_numbers_page.dart';
import 'package:vecino_vigilante/pages/new_complaint_page.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: RoutesEnum.home.path,
      builder: (BuildContext context, GoRouterState state) {
        return const AllComplaintsPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: "complaints/:complaintId",
          builder: (
            BuildContext context,
            GoRouterState state,
          ) {
            return ComplaintPage(
              complaintId: state.pathParameters['complaintId'],
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: RoutesEnum.crimeMap.path,
      builder: (
        BuildContext context,
        GoRouterState state,
      ) {
        return const CrimeMapPage();
      },
    ),
    GoRoute(
      path: RoutesEnum.newComplaint.path,
      builder: (
        BuildContext context,
        GoRouterState state,
      ) {
        return NewComplaintPage();
      },
    ),
    GoRoute(
      path: RoutesEnum.emergencyNumbers.path,
      builder: (
        BuildContext context,
        GoRouterState state,
      ) {
        return const EmergencyNumbersPage();
      },
    ),
  ],
);
