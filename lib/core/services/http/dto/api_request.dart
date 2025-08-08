class ApiRequest {
  final String path;
  final Map<String, String>? headers;
  final Object? body;

  const ApiRequest({required this.path, this.headers, this.body});

  String getFullUrl(String baseUrl) {
    return '$baseUrl$path';
  }
}
