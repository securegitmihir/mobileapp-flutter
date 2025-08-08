import 'package:auth_todo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:auth_todo/features/auth/presentation/controllers/auth_form_controller.dart';
import 'package:auth_todo/features/auth/presentation/widgets/auth_button.dart';
import 'package:auth_todo/features/auth/presentation/widgets/auth_error.dart';
import 'package:auth_todo/features/auth/presentation/widgets/auth_form.dart';
import 'package:auth_todo/features/auth/presentation/widgets/auth_header.dart';
import 'package:auth_todo/features/auth/presentation/widgets/auth_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formController = AuthFormController();

  @override
  void dispose() {
    _formController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (BuildContext context, AuthState state) {
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AuthHeader(controller: _formController),
                  const SizedBox(height: 32),
                  AuthForm(controller: _formController),
                  const SizedBox(height: 24),
                  AuthButton(controller: _formController),
                  const SizedBox(height: 16),
                  AuthErrorWidget(controller: _formController),
                  const SizedBox(height: 24),
                  AuthToggleButton(controller: _formController),
                ],
              ),
            ),
          );
        },
        listener: (context, AuthState state) {
          if (state is AuthSuccess) {
            context.go('/home');
          }
        },
      ),
    );
  }
}
