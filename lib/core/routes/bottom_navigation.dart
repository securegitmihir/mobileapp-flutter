import 'package:auth_todo/core/constants/constants.dart';
import 'package:auth_todo/core/routes/route_navigator_keys.dart';
import 'package:auth_todo/core/theme/app_theme.dart';
import 'package:auth_todo/core/theme/theme_state.dart';
import 'package:auth_todo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:auth_todo/features/profile/presentation/pages/profile_screen.dart';
import 'package:auth_todo/features/todo/presentation/pages/todo_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'My todos',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ThemeState>(context, listen: false).changeTheme();
            },
            icon: Icon(
              Provider.of<ThemeState>(context, listen: false).themeType ==
                      ThemeType.light
                  ? Icons.nightlight
                  : Icons.sunny,
            ),
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () {
              context.read<AuthBloc>().add(AuthSignOut());
            },
          ),
        ],
      ),
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
