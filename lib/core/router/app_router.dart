import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_fortitu/features/home/presentation/screens/screens.dart';
import 'package:mi_fortitu/features/login/presentation/screens/screens.dart';

import '../../features/home/presentation/screens/clusters_screen.dart';
import '../../features/home/presentation/screens/coalitions_screen.dart';
import '../../features/home/presentation/screens/eval_slots_screen.dart';
import '../../features/home/presentation/screens/finder_screen.dart';
import '../../features/home/presentation/screens/leagues_screeen.dart';
import '../../features/home/presentation/screens/profile_screen.dart';
import '../../features/home/presentation/screens/projects_screen.dart';
import '../../features/home/presentation/screens/settings_screen.dart';
import '../../features/home/presentation/screens/shop_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
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
    GoRoute(
      path: '/profile',
      pageBuilder: (context, state) => MaterialPage(child: ProfileScreen()),
    ),
    GoRoute(
      path: '/projects',
      pageBuilder: (context, state) => MaterialPage(child: ProjectsScreen()),
    ),
    GoRoute(
      path: '/slots',
      pageBuilder: (context, state) => MaterialPage(child: EvalSlotsScreen()),
    ),
    GoRoute(
      path: '/shop',
      pageBuilder: (context, state) => MaterialPage(child: ShopScreen()),
    ),
    GoRoute(
      path: '/settings',
      pageBuilder: (context, state) => MaterialPage(child: SettingsScreen()),
    ),
    GoRoute(
      path: '/finder',
      pageBuilder: (context, state) => MaterialPage(child: FinderScreen()),
    ),
    GoRoute(
      path: '/clusters',
      pageBuilder: (context, state) => MaterialPage(child: ClustersScreen()),
    ),
    GoRoute(
      path: '/coalitions',
      pageBuilder: (context, state) => MaterialPage(child: CoalitionsScreen()),
    ),
    GoRoute(
      path: '/leagues',
      pageBuilder: (context, state) => MaterialPage(child: LeaguesScreen()),
    ),
  ],
  redirect: (BuildContext context, GoRouterState state) {
    // DEBUG
    if (state.uri.toString().contains('/intra-callback')) {
      return '/login';
    } else if (state.uri.toString().contains('/login-callback')) {
      return '/login';
    }
  },
);
