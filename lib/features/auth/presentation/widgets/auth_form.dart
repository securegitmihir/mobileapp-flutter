import 'package:auth_todo/features/auth/presentation/controllers/auth_form_controller.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatelessWidget {
  final AuthFormController controller;

  const AuthForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: ValueListenableBuilder(
        valueListenable: controller.isLoginNotifier,
        builder: (context, isLogin, child) {
          return Column(
            children: [
              _buildUsernameField(),
              const SizedBox(height: 16),
              _buildPasswordField(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildUsernameField() {
    return TextFormField(
      controller: controller.usernameController,
      decoration: InputDecoration(
        labelText: 'Username',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      validator: _validateUsername,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: controller.passwordController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      validator: _validatePassword,
    );
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    if (value.length < 8) {
      return 'Username must be at least 8 characters';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }
}
