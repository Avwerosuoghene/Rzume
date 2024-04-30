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
      T Function(Map<String, dynamic>)? fromJsonT) {
    return ApiResult<T>(
      content: parsedJson['content'] != null && fromJsonT != null
          ? fromJsonT(parsedJson['content'] as Map<String, dynamic>)
          : parsedJson['content'] as T?,
      message: parsedJson['message'] as String,
    );
  }
}

class SigninResponse {
  SigninResponse(
      {required this.user,
      required this.token,
      required this.message,
      required this.emailConfirmed});
  final Map<String, dynamic> user;
  final String token;
  final String message;
  final bool emailConfirmed;

  factory SigninResponse.fromJson(Map<String, dynamic> parsedJson) {
    return SigninResponse(
        user: parsedJson['user'] as Map<String, dynamic>,
        token: parsedJson['token'] as String,
        message: parsedJson['token'] as String,
        emailConfirmed: parsedJson['emailConfirmed'] as bool);
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

class GetUniversityResponse {
  GetUniversityResponse({required this.country, required this.name});

  final String country;
  final String name;
  factory GetUniversityResponse.fromJson(Map<String, dynamic> parsedJson) {
    return GetUniversityResponse(
      country: parsedJson['country'] as String,
      name: parsedJson['name'] as String,
    );
  }
}

class OtpPasswordResetResponse {
  OtpPasswordResetResponse({required this.isSuccess, required this.message});

  final bool isSuccess;
  final String message;
  factory OtpPasswordResetResponse.fromJson(Map<String, dynamic> parsedJson) {
    return OtpPasswordResetResponse(
        isSuccess: parsedJson['isSuccess'] as bool,
        message: parsedJson['message'] as String);
  }
}

class GenericResponse {
  GenericResponse({required this.isSuccess});

  final bool isSuccess;

  factory GenericResponse.fromJson(Map<String, dynamic> parsedJson) {
    return GenericResponse(isSuccess: parsedJson['isSuccess'] as bool);
  }
}

// This takes a json array and converts to an iterable
class JsonArrayReesponse {
  JsonArrayReesponse({required this.data});

  final List<dynamic> data;

  factory JsonArrayReesponse.fromJson(List<dynamic> json) {
    return JsonArrayReesponse(
        data: json.map((item) => item as dynamic).toList());
  }
}
