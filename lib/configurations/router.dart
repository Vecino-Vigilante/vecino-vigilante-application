import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vecino_vigilante/configurations/routes_enum.dart';
import 'package:vecino_vigilante/http/responses/authenticated_user_response.dart';
import 'package:vecino_vigilante/pages/all_complaints_page.dart';
import 'package:vecino_vigilante/pages/complaint_page.dart';
import 'package:vecino_vigilante/pages/crime_map_page.dart';
import 'package:vecino_vigilante/pages/emergency_numbers_page.dart';
import 'package:vecino_vigilante/pages/login_page.dart';
import 'package:vecino_vigilante/pages/new_complaint_page.dart';
import 'package:vecino_vigilante/pages/signup_page.dart';
import 'package:vecino_vigilante/utils/auth_utils.dart';

Future<String?> _authGuard(BuildContext context, GoRouterState state) async {
  AuthenticatedUserResponseDTO? authUser =
      await AuthUtils.getAuthenticatedUser();

  if (authUser == null) {
    return RoutesEnum.login.path;
  }

  return null;
}

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: "/login",
      builder: (BuildContext context, GoRouterState state) {
        return LoginPage();
      },
    ),
    GoRoute(
      path: "/signup",
      builder: (BuildContext context, GoRouterState state) {
        return SignUpPage();
      },
    ),
    GoRoute(
      path: "/",
      builder: (BuildContext context, GoRouterState state) {
        return const AllComplaintsPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: "complaints/:complaintId",
          builder: (BuildContext context, GoRouterState state) {
            return ComplaintPage(
              complaintId: state.pathParameters['complaintId'],
            );
          },
          redirect: (BuildContext context, GoRouterState state) async {
            return await _authGuard(context, state);
          },
        ),
      ],
      redirect: (BuildContext context, GoRouterState state) async {
        return await _authGuard(context, state);
      },
    ),
    GoRoute(
      path: "/crime-map",
      builder: (BuildContext context, GoRouterState state) {
        return const CrimeMapPage();
      },
      redirect: (BuildContext context, GoRouterState state) async {
        return await _authGuard(context, state);
      },
    ),
    GoRoute(
      path: "/new-complaint",
      builder: (BuildContext context, GoRouterState state) {
        return NewComplaintPage();
      },
      redirect: (BuildContext context, GoRouterState state) async {
        return await _authGuard(context, state);
      },
    ),
    GoRoute(
      path: "/emergency-numbers",
      builder: (BuildContext context, GoRouterState state) {
        return const EmergencyNumbersPage();
      },
      redirect: (BuildContext context, GoRouterState state) async {
        return await _authGuard(context, state);
      },
    ),
  ],
);
