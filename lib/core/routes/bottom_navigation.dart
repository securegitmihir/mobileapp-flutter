import 'package:auth_todo/core/constants/constants.dart';
import 'package:auth_todo/core/routes/route_navigator_keys.dart';
import 'package:auth_todo/features/profile/presentation/pages/profile_screen.dart';
import 'package:auth_todo/features/todo/presentation/pages/todo_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

final bottomNavigation = StatefulShellRoute.indexedStack(
  builder: (context, state, child) {
    return BottomNavigation(navigationShell: child);
  },
  branches: [
    StatefulShellBranch(
      navigatorKey: homeTabNavigatorKey,
      routes: [
        GoRoute(
          path: RoutePaths.home,
          builder: (context, state) => TodoHomeScreen(),
        ),
      ],
    ),
    StatefulShellBranch(
      navigatorKey: profileTabNavigatorKey,
      routes: [
        GoRoute(
          path: RoutePaths.profile,
          builder: (context, state) => ProfileScreen(),
        ),
      ],
    ),
  ],
);
