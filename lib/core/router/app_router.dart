import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:mi_fortitu/features/login/presentation/screens/screens.dart';
import 'package:mi_fortitu/features/home/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) => MaterialPage(child: HomeScreen()),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => MaterialPage(child: LoginScreen()),
    ),
    GoRoute(
      path: '/waitlist',
      pageBuilder: (context, state) => MaterialPage(child: WaitlistScreen()),
    ),
  ],
  redirect: (BuildContext context, GoRouterState state) {
    print('Entrada en redirect del router\nDirección: ${state.uri.toString()}'); // DEBUG
    if (state.uri.toString().contains('/intra-callback')) {
      print('Encuentra /intra-callback. Redirige a login'); // DEBUG
      return '/login';
    } else if (state.uri.toString().contains('/login-callback')) {
      print('Encuentra /login-callback. Redirige a login'); // DEBUG
      return '/login';
    }
  }
);
