import 'dart:convert';

import 'misc-type.dart';

class ApiResponse<T> {
  ApiResponse(
      {required this.statusCode,
      required this.isSuccess,
      required this.errorMessages,
      required this.result});

  final num statusCode;
  final bool isSuccess;
  final List<dynamic> errorMessages;
  final ApiResult? result;

  factory ApiResponse.fromJson(Map<String, dynamic> parsedJson,
      T Function(Map<String, dynamic>)? fromJsonT) {
    return ApiResponse<T>(
      statusCode: parsedJson['statusCode'] as int,
      isSuccess: parsedJson['isSuccess'] as bool,
      errorMessages: parsedJson['errorMessages'] as List<dynamic>,
      result: parsedJson['result'] != null
          ? ApiResult<T>.fromJson(
              parsedJson['result'] as Map<String, dynamic>,
              fromJsonT ?? ((json) => json as T),
            )
          : null,
    );
  }
}

class ApiResult<T> {
  ApiResult({required this.content, required this.message});

  final T? content;
  final String message;

  factory ApiResult.fromJson(Map<String, dynamic> parsedJson,
      T Function(Map<String, dynamic>) fromJsonT) {
    return ApiResult<T>(
      content: parsedJson['content'] != null
          ? fromJsonT(parsedJson['content'] as Map<String, dynamic>)
          : null,
      message: parsedJson['message'] as String,
    );
  }
}

class SigninResponse {
  SigninResponse({
    required this.user,
    required this.token,
  });
  final Map<String, dynamic> user;
  final String token;

  factory SigninResponse.fromJson(Map<String, dynamic> parsedJson) {
    return SigninResponse(
      user: parsedJson['user'] as Map<String, dynamic>,
      token: parsedJson['token'] as String,
    );
  }
}

class SignupResponse {
  SignupResponse({required this.isCreated});

  final bool isCreated;
factory SignupResponse.fromJson(Map<String, dynamic> parsedJson) {
    return SignupResponse(
      isCreated: parsedJson['isCreated'] as bool,
    );
  }

}
