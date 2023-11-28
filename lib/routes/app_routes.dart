import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:prova_flutter_target_sistemas/data/services/authenticated/i_user_session_manager.dart';
import 'package:prova_flutter_target_sistemas/domian/entities/user_session.dart';
import 'package:prova_flutter_target_sistemas/presentation/informations/informations_page.dart';
import 'package:prova_flutter_target_sistemas/presentation/login/login_page.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    redirect: (context, state) async {
      final userSessionManager = GetIt.I.get<IUserSessionManager>();
      final UserSession? authenticatedUserSession = await userSessionManager.getAuthenticatedUser();
      if (authenticatedUserSession?.isAuthenticated == true) {
        return '/informations';
      }
      return null;
    },
    routes: <RouteBase>[
      //TODO Criar splashscreen
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: '/informations',
        builder: (BuildContext context, GoRouterState state) {
          return const InformationsPage();
        },
      ),
    ],
    //debugLogDiagnostics: true,
  );
}
