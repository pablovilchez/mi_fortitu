import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_fortitu/features/auth/presentation/screens/screens.dart';


final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      pageBuilder: (context, state) => MaterialPage(child: SplashScreen()),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => MaterialPage(child: LoginScreen()),
    ),
    GoRoute(
      path: '/register',
      pageBuilder: (context, state) => MaterialPage(child: RegisterScreen()),
    ),
    GoRoute(
      path: '/home',
      pageBuilder:
          (context, state) => MaterialPage(
            child: Scaffold(
              appBar: AppBar(title: Text('Home')),
              body: Center(child: Text('Home Screen')),
            ),
          ),
    ),
    GoRoute(
      path: '/waitlist',
      pageBuilder: (context, state) => MaterialPage(child: WaitlistScreen()),
    ),
    GoRoute(
      path: '/login-callback',
      pageBuilder: (context, state) => MaterialPage(child: LoginScreen()),
    ),
  ],
);
