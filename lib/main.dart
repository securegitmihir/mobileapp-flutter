import 'package:auth_todo/core/theme/app_theme.dart';
import 'package:auth_todo/core/theme/theme_state.dart';
import 'package:auth_todo/init_dependencies.dart';
import 'package:auth_todo/core/routes/app_router.dart';
import 'package:auth_todo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:auth_todo/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (_) => serviceLocator<TodoBloc>()),
      ],
      child: ChangeNotifierProvider(
        create: (_) => ThemeState(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthCheckLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'My todo',
      theme:
          Provider.of<ThemeState>(context, listen: true).themeType ==
              ThemeType.light
          ? AppTheme.lightThemeMode
          : AppTheme.darkThemeMode,
    );
  }
}
