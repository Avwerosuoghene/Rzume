import 'dart:convert';

class ApiResponse {
  ApiResponse(
      {required this.statusCode,
      required this.isSuccess,
      required this.errorMessages,
      required this.result});

  final num statusCode;
  final bool isSuccess;
  final List<dynamic> errorMessages;
  final Object? result;

  factory ApiResponse.fromJson(Map<String, dynamic> parsedJson) {
    return ApiResponse(
      statusCode: parsedJson['statusCode'] as int,
      isSuccess: parsedJson['isSuccess'] as bool,
      errorMessages: parsedJson['errorMessages'] as List<dynamic>,
      result: parsedJson['result'] as Object?,
    );
  }
}
