import 'package:auth_todo/core/services/http/dto/api_request.dart';
import 'package:auth_todo/core/services/http/dto/api_response.dart';

abstract interface class ApiClient {
  final String baseUrl;

  ApiClient({required this.baseUrl});

  Future<ApiResponse> getMany(ApiRequest request);
  Future<ApiResponse> post(ApiRequest request);
  Future<ApiResponse> getOne(ApiRequest request);
  Future<ApiResponse> patch(ApiRequest request);
  Future<ApiResponse> delete(ApiRequest request);
}
