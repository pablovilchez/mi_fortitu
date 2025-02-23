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
  ],
);
