import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prova_flutter_target_sistemas/presentation/informations/informations_page.dart';
import 'package:prova_flutter_target_sistemas/presentation/login/login_page.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      //TODO Criar splashscreen
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'informations',
            builder: (BuildContext context, GoRouterState state) {
              return const InformationsPage();
            },
          ),
        ],
      ),
    ],
  );
}
