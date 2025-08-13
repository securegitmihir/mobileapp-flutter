import 'package:auth_todo/features/auth/data/model/user_model.dart';

abstract class AuthApiProvider {
  Future<UserModel> signIn(String username, String password);
  Future<UserModel> signUp(String username, String password);
  Future<bool> checkLoggedIn(String token);
}
