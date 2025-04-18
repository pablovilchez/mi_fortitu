import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_fortitu/features/auth/presentation/screens/screens.dart';
import 'package:mi_fortitu/features/clusters/presentation/screens/screens.dart';
import 'package:mi_fortitu/features/coalitions_blocs/presentation/screens/screens.dart';
import 'package:mi_fortitu/features/home/presentation/screens/screens.dart';
import 'package:mi_fortitu/features/leagues/presentation/screens/screens.dart';
import 'package:mi_fortitu/features/peers/presentation/screens/screens.dart';
import 'package:mi_fortitu/features/profiles/presentation/screens/screens.dart';
import 'package:mi_fortitu/features/settings/presentation/screens/screens.dart';
import 'package:mi_fortitu/features/shop/presentation/screens/screens.dart';
import 'package:mi_fortitu/features/slots/presentation/screens/screens.dart';


final appRouter = GoRouter(
  initialLocation: '/auth',
  routes: [
    GoRoute(path: '/auth', pageBuilder: (context, state) => MaterialPage(child: LoginScreen())),
    GoRoute(
      path: '/login-callback',
      pageBuilder: (context, state) => const MaterialPage(child: SizedBox.shrink()),
    ),
    GoRoute(path: '/home', pageBuilder: (context, state) => MaterialPage(child: HomeScreen())),
    GoRoute(
      path: '/waitlist',
      pageBuilder: (context, state) => MaterialPage(child: WaitlistScreen()),
    ),
    GoRoute(
      path: '/profile',
      pageBuilder: (context, state) => MaterialPage(child: ProfileScreen()),
    ),
    GoRoute(
      path: '/search-students',
      pageBuilder: (context, state) => MaterialPage(child: SearchStudentsScreen()),
    ),
    GoRoute(
      path: '/slots',
      pageBuilder: (context, state) => MaterialPage(child: SlotsScreen()),
    ),
    GoRoute(path: '/shop', pageBuilder: (context, state) => MaterialPage(child: ShopScreen())),
    GoRoute(
      path: '/settings',
      pageBuilder: (context, state) => MaterialPage(child: SettingsScreen()),
    ),
    GoRoute(path: '/finder', pageBuilder: (context, state) => MaterialPage(child: PeerToPeerScreen())),
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
    if (state.uri.toString().contains('/login-callback')) {
      return '/auth';
    } else {
      return null;
    }
  },
);
