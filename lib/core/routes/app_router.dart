import 'package:auth_todo/core/constants/constants.dart';
import 'package:auth_todo/core/routes/bottom_navigation.dart';
import 'package:auth_todo/core/routes/route_navigator_keys.dart';
import 'package:auth_todo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:auth_todo/features/auth/presentation/pages/auth_screen.dart';
import 'package:auth_todo/features/splash/presentation/pages/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// TODO - Navigation with BLoC
// TODO - Test Cases.
//TODO - Token Validation logic

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
    bottomNavigation,
  ],
);
