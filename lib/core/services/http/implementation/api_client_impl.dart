import 'dart:convert';
import 'package:auth_todo/core/constants/constants.dart';
import 'package:auth_todo/core/services/http/interface/api_client.dart';
import 'package:auth_todo/core/services/http/dto/api_response.dart';
import 'package:auth_todo/core/services/http/dto/api_request.dart';
import 'package:http/http.dart' as http;

class ApiClientImpl implements ApiClient {
  @override
  final String baseUrl;

  ApiClientImpl({required this.baseUrl});

  @override
  Future<ApiResponse> getMany(ApiRequest request) async {
    final response = await http.get(
      Uri.parse(request.getFullUrl(baseUrl)),
      headers: mergeHeaders(request.headers),
    );
    return processResponseArray(response);
  }

  @override
  Future<ApiResponse> post(ApiRequest request) async {
    final response = await http.post(
      Uri.parse(request.getFullUrl(baseUrl)),
      headers: mergeHeaders(request.headers),
      body: request.body != null ? jsonEncode(request.body) : null,
    );
    return processResponse(response);
  }

  @override
  Future<ApiResponse> getOne(ApiRequest request) async {
    final response = await http.get(
      Uri.parse(request.getFullUrl(baseUrl)),
      headers: mergeHeaders(request.headers),
    );
    return processResponse(response);
  }

  @override
  Future<ApiResponse> patch(ApiRequest request) async {
    final response = await http.patch(
      Uri.parse(request.getFullUrl(baseUrl)),
      headers: mergeHeaders(request.headers),
      body: request.body != null ? jsonEncode(request.body) : null,
    );
    return processResponse(response);
  }

  @override
  Future<ApiResponse> delete(ApiRequest request) async {
    final response = await http.delete(
      Uri.parse(request.getFullUrl(baseUrl)),
      headers: mergeHeaders(request.headers),
      body: request.body != null ? jsonEncode(request.body) : null,
    );
    return processResponse(response);
  }

  Map<String, String> mergeHeaders(Map<String, String>? headers) {
    return {'Content-Type': 'application/json', ...?headers};
  }

  ApiResponse processResponse(http.Response response) {
    final data = response.body.isNotEmpty ? jsonDecode(response.body) : {};
    final statusCode = response.statusCode;

    switch (response.statusCode) {
      case 200:
      case 201:
        if (response.body.isEmpty) {
          return ApiResponse.success(data: {}, statusCode: statusCode);
        }
        return ApiResponse.fromJson(data);
      case 204:
        return ApiResponse.success(data: {}, statusCode: statusCode);
      default:
        final errorMessage = data['message'] ?? apiErrorMessages[statusCode];
        return ApiResponse.error(message: errorMessage, statusCode: statusCode);
    }
  }

  ApiResponse processResponseArray(http.Response response) {
    final data = response.body.isNotEmpty ? jsonDecode(response.body) : {};
    final statusCode = response.statusCode;

    switch (response.statusCode) {
      case 200:
      case 201:
        if (response.body.isEmpty) {
          return ApiResponse.success(dataList: [], statusCode: statusCode);
        }
        return ApiResponse.fromJson(data);
      case 204:
        return ApiResponse.success(dataList: [], statusCode: statusCode);
      default:
        final errorMessage = data['message'] ?? apiErrorMessages[statusCode];
        return ApiResponse.error(message: errorMessage, statusCode: statusCode);
    }
  }
}
