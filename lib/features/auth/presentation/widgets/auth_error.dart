import 'package:auth_todo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:auth_todo/features/auth/presentation/controllers/auth_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthErrorWidget extends StatelessWidget {
  final AuthFormController controller;
  const AuthErrorWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.isLoginNotifier,
      builder: (context, isLogin, child) {
        return _buildErrorWidget();
      },
    );
  }

  Widget _buildErrorWidget() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthFailure) {
          return Text(
            state.message,
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
              fontSize: 14,
            ),
          );
        }
        return const SizedBox(height: 0);
      },
    );
  }
}
