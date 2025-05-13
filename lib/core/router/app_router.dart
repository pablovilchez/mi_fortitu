import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_fortitu/features/access/presentation/screens/screens.dart';
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
    GoRoute(path: '/auth', pageBuilder: (context, state) => const MaterialPage(child: LoginScreen())),
    GoRoute(
      path: '/login-callback',
      pageBuilder: (context, state) => const MaterialPage(child: SizedBox.shrink()),
    ),
    GoRoute(path: '/reset-password', pageBuilder: (context, state) => const MaterialPage(child: ResetPasswordScreen())),
    GoRoute(path: '/home', pageBuilder: (context, state) => const MaterialPage(child: HomeScreen())),
    GoRoute(
      path: '/waitlist',
      pageBuilder: (context, state) => const MaterialPage(child: WaitlistScreen()),
    ),
    GoRoute(
      path: '/profile',
      pageBuilder: (context, state) => const MaterialPage(child: UserProfileScreen()),
    ),
    GoRoute(
      path: '/search-students',
      pageBuilder: (context, state) => const MaterialPage(child: SearchStudentsScreen()),
    ),
    GoRoute(
      path: '/search-students/:loginName',
      pageBuilder: (context, state) {
        final loginName = state.pathParameters['loginName'];
        return MaterialPage(child: SearchStudentsScreen(loginName: loginName));
      },
    ),
    GoRoute(path: '/slots', pageBuilder: (context, state) => const MaterialPage(child: ManageSlotsScreen())),
    GoRoute(path: '/shop', pageBuilder: (context, state) => const MaterialPage(child: ShopScreen())),
    GoRoute(
      path: '/settings',
      pageBuilder: (context, state) => MaterialPage(child: SettingsScreen()),
    ),
    GoRoute(
      path: '/finder',
      pageBuilder: (context, state) => const MaterialPage(child: PeerToPeerScreen()),
    ),
    GoRoute(
      path: '/clusters',
      pageBuilder: (context, state) => const MaterialPage(child: ClustersScreen()),
    ),
    GoRoute(
      path: '/coalitions',
      pageBuilder: (context, state) => const MaterialPage(child: CoalitionsScreen()),
    ),
    GoRoute(
      path: '/leagues',
      pageBuilder: (context, state) => const MaterialPage(child: LeaguesScreen()),
    ),
  ],
  redirect: (BuildContext context, GoRouterState state) {
    if (state.uri.toString().contains('/login-callback')) {
      return '/auth';
    } else if (state.uri.toString().contains('/reset-password')) {
      return '/reset-password';
    } else {
      return null;
    }
  },
);
