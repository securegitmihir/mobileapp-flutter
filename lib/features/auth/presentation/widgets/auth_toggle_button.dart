import 'package:auth_todo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:auth_todo/features/auth/presentation/controllers/auth_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthToggleButton extends StatelessWidget {
  final AuthFormController controller;

  const AuthToggleButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: controller.isLoginNotifier,
      builder: (context, isLogin, child) {
        return TextButton(
          onPressed: () {
            context.read<AuthBloc>().add(AuthResetForm());
            controller.toggleMode();
          },
          child: Text(
            isLogin ? 'First time? Register.' : 'Already registered? Login.',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        );
      },
    );
  }
}
