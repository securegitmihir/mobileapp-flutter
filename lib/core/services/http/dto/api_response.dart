class ApiResponse {
  final Map<String, dynamic>? data;
  final List<Map<String, dynamic>>? dataList;
  final String? message;
  final bool success;
  final int statusCode;

  const ApiResponse({
    this.data,
    this.dataList,
    this.message,
    required this.success,
    required this.statusCode,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    final responseData = json['data'];
    Map<String, dynamic>? singleData;
    List<Map<String, dynamic>>? multipleData;

    if (responseData is Map<String, dynamic>) {
      singleData = responseData;
    } else if (responseData is List) {
      multipleData = responseData.cast<Map<String, dynamic>>();
    }

    return ApiResponse(
      data: singleData,
      dataList: multipleData,
      message: json['message'] as String?,
      success: json['success'] as bool? ?? true,
      statusCode: json['statusCode'] as int? ?? 200,
    );
  }

  factory ApiResponse.success({
    Map<String, dynamic>? data,
    List<Map<String, dynamic>>? dataList,
    String? message,
    required int statusCode,
  }) {
    return ApiResponse(
      data: data,
      dataList: dataList,
      message: message,
      success: true,
      statusCode: statusCode,
    );
  }

  factory ApiResponse.error({
    String message = "Unexpected error",
    required int statusCode,
  }) {
    return ApiResponse(
      data: null,
      dataList: null,
      message: message,
      success: false,
      statusCode: statusCode,
    );
  }
}
