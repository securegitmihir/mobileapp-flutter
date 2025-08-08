import 'package:auth_todo/features/auth/presentation/controllers/auth_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthHeader extends StatelessWidget {
  final AuthFormController controller;

  const AuthHeader({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: controller.isLoginNotifier,
      builder: (context, isLogin, child) {
        return Column(
          children: [
            Text(
              isLogin ? 'Login' : 'Register',
              style: GoogleFonts.montserrat(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isLogin ? 'Welcome back!' : 'Create your account',
              style: GoogleFonts.poppins(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 20,
              ),
            ),
          ],
        );
      },
    );
  }
}
