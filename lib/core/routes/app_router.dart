import 'package:auth_todo/core/constants/constants.dart';
import 'package:auth_todo/core/routes/route_navigator_keys.dart';
import 'package:auth_todo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:auth_todo/features/auth/presentation/pages/auth_screen.dart';
import 'package:auth_todo/features/profile/presentation/pages/profile_screen.dart';
import 'package:auth_todo/features/splash/presentation/pages/splash_screen.dart';
import 'package:auth_todo/features/todo/presentation/pages/todo_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: RoutePaths.splash,
  redirect: (context, state) {
    final authState = context.read<AuthBloc>().state;
    bool isAuthenticated = authState is AuthSuccess;

    if (!isAuthenticated &&
        RoutePaths.protectedRoutes.contains(state.uri.path)) {
      return RoutePaths.auth;
    }
    return null;
  },
  routes: [
    GoRoute(
      path: RoutePaths.splash,
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(path: RoutePaths.auth, builder: (context, state) => AuthScreen()),
    ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.uri.path == RoutePaths.home ? 0 : 1,
            onTap: (index) {
              if (index == 0) {
                context.go(RoutePaths.home);
              } else {
                context.go(RoutePaths.profile);
              }
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
      routes: [
        GoRoute(
          path: RoutePaths.home,
          builder: (context, state) => TodoHomeScreen(),
        ),
        GoRoute(
          path: RoutePaths.profile,
          builder: (context, state) => ProfileScreen(),
        ),
      ],
    ),
  ],
);
