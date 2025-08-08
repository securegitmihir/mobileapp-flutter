import 'package:auth_todo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthFormController {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final ValueNotifier<bool> _isLoginNotifier = ValueNotifier<bool>(true);

  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get usernameController => _usernameController;
  TextEditingController get passwordController => _passwordController;
  bool get isLogin => _isLoginNotifier.value;
  ValueNotifier<bool> get isLoginNotifier => _isLoginNotifier;

  void toggleMode() {
    _isLoginNotifier.value = !_isLoginNotifier.value;
    _passwordController.clear();
    _usernameController.clear();
  }

  void submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (_isLoginNotifier.value) {
        context.read<AuthBloc>().add(
          AuthLogin(
            username: _usernameController.text.trim(),
            password: _passwordController.text,
          ),
        );
      } else {
        context.read<AuthBloc>().add(
          AuthSignUp(
            username: _usernameController.text.trim(),
            password: _passwordController.text,
          ),
        );
      }
    }
  }

  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _isLoginNotifier.dispose();
  }
}
