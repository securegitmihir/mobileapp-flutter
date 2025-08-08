import 'package:auth_todo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:auth_todo/features/auth/presentation/controllers/auth_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthButton extends StatelessWidget {
  final AuthFormController controller;

  const AuthButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: state is AuthLoading
                ? null
                : () => controller.submitForm(context),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                Theme.of(context).colorScheme.primary,
              ),
              foregroundColor: WidgetStateProperty.all(
                Theme.of(context).colorScheme.onPrimary,
              ),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
            ),
            child: state is AuthLoading
                ? const CircularProgressIndicator(
                    constraints: BoxConstraints(
                      maxHeight: 18,
                      maxWidth: 18,
                      minHeight: 18,
                      minWidth: 18,
                    ),
                    color: Colors.white,
                  )
                : ValueListenableBuilder<bool>(
                    valueListenable: controller.isLoginNotifier,
                    builder: (context, isLogin, child) {
                      return Text(isLogin ? 'Login' : 'Register');
                    },
                  ),
          ),
        );
      },
    );
  }
}
