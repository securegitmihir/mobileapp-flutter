import 'package:auth_todo/core/constants/constants.dart';
import 'package:auth_todo/core/error/exception.dart';
import 'package:auth_todo/core/services/http/api_client.dart';
import 'package:auth_todo/core/services/http/dto/api_request.dart';
import 'package:auth_todo/features/auth/data/model/user_model.dart';
import 'package:auth_todo/features/auth/data/provider/auth_api_provider.dart';

class AuthApiProviderImpl implements AuthApiProvider {
  final ApiClient _apiClient;
  AuthApiProviderImpl(this._apiClient);

  @override
  Future<UserModel> signIn(String username, String password) async {
    try {
      ApiRequest request = ApiRequest(
        path: ApiUrls.login,
        body: {'username': username, 'password': password},
      );
      final response = await _apiClient.post(request);

      if (!response.success) {
        throw Exception(response.message ?? 'Login - Request failed');
      }

      final user = UserModel.fromJson(response.data!);

      return user;
    } on ServerException catch (e) {
      throw Exception('Login - Request failed: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> signUp(String username, String password) async {
    try {
      ApiRequest request = ApiRequest(
        path: ApiUrls.register,
        body: {'username': username, 'password': password},
      );
      final response = await _apiClient.post(request);

      if (!response.success) {
        throw Exception(response.message ?? 'Sign up - Request failed');
      }

      final user = UserModel.fromJson(response.data!);

      return user;
    } on ServerException catch (e) {
      throw Exception('Sign up - Request failed: ${e.toString()}');
    }
  }

  @override
  Future<bool> checkLoggedIn(String token) async {
    try {
      ApiRequest request = ApiRequest(
        path: ApiUrls.checkLoggedIn,
        headers: {'Authorization': 'Bearer $token'},
      );
      final response = await _apiClient.getOne(request);

      if (!response.success) {
        throw Exception(response.message ?? 'Check logged in - Request failed');
      }
      return response.data != null && response.data.toString().isNotEmpty;
    } on ServerException catch (e) {
      throw ServerException(
        'Check logged in - Request failed: ${e.toString()}',
      );
    }
  }
}
