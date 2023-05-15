import 'package:courtinfo_spark/components/BottomNav.dart';
import 'package:courtinfo_spark/screens/camera/CameraScreen.dart';
import 'package:courtinfo_spark/screens/home/HomeScreen.dart';
import 'package:courtinfo_spark/screens/login/login_screen.dart';
import 'package:courtinfo_spark/screens/settings/SettingScreen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: 'camera',
      path: '/camera',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => const CameraScreen(),
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
