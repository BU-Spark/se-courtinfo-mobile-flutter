import 'package:courtinfo_spark/components/BottomNav.dart';
import 'package:courtinfo_spark/screens/camera/CameraScreen.dart';
import 'package:courtinfo_spark/screens/camera/scanDocScreen.dart';
import 'package:courtinfo_spark/screens/home/HomeScreen.dart';
import 'package:courtinfo_spark/screens/settings/SettingScreen.dart';
import 'package:courtinfo_spark/screens/login/log_in.dart';
import 'package:courtinfo_spark/screens/signup/sign_up.dart';
import 'package:courtinfo_spark/main.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: rootNavigatorKey,
  routes: [
    GoRoute(
      name: 'welcome',
      path: '/',
      parentNavigatorKey: rootNavigatorKey,
      redirect: (context, state) {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        print('login status: ${authProvider.loggedInStatus}');
        if (authProvider.loggedInStatus == Status.LoggedIn) {
          return '/home';
        }
        return null;
      },
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      name: 'camera',
      path: '/camera',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => const CameraScreen(),
    ),
    GoRoute(
      name: 'ScanDocScreen',
      path: '/ScanDocScreen',
      parentNavigatorKey: rootNavigatorKey,
      pageBuilder: (context, state) {
        final queryParams = state.queryParameters;
        final minPageCount = int.tryParse(queryParams['minPageCount'] ?? '1') ?? 1;
        return MaterialPage(child: ScanDocScreen(minPageCount: minPageCount));
      },
    ),
    GoRoute(
      name: 'login',
      path: '/log_in',
      parentNavigatorKey: rootNavigatorKey,
      pageBuilder: (context, state) =>
          NoTransitionPage(key: state.pageKey, child: const Login()),
    ),
    GoRoute(
      name: 'signup',
      path: '/sign_up',
      parentNavigatorKey: rootNavigatorKey,
      pageBuilder: (context, state) =>
          NoTransitionPage(key: state.pageKey, child: const SignUp()),
    ),
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      builder: (context, state, child) {
        return BottomNav(
          child: child,
        );
      },
      routes: [
        GoRoute(
          name: 'home',
          path: '/home',
          parentNavigatorKey: shellNavigatorKey,
          pageBuilder: (context, state) =>
              NoTransitionPage(key: state.pageKey, child: const HomeScreen()),
        ),
        GoRoute(
          name: 'settings',
          path: '/settings',
          parentNavigatorKey: shellNavigatorKey,
          pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey, child: const SettingScreen()),
        ),
        // builder: (context, state) => const SettingScreen(),
      ],
    )
  ],
);
