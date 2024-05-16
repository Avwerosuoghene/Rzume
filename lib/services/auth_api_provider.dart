import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../model/api_routes.dart';
import '../model/response_payload.dart';

class AuthAPIProvider {
  static final logger = Logger(
      printer:
          PrettyPrinter(methodCount: 0, errorMethodCount: 3, lineLength: 50));

  static Future<ApiResponse<SigninResponse>> login(dynamic payload) async {
    final Uri url = Uri.parse('${APIRoutes.authServiceUrl}/login');

    try {
      return http.post(url, body: payload, headers: {
        'Content-Type': 'application/json',
      }).then((http.Response response) {
        final Map<String, dynamic> mappedResponse = json.decode(response.body);
        final ApiResponse<SigninResponse> loginResponseObj =
            ApiResponse.fromJson(mappedResponse, SigninResponse.fromJson);
        logger.i('login response succesful: ${loginResponseObj.isSuccess}');
        return loginResponseObj;
      });
    } catch (error) {
      rethrow;
    }
  }

  static Future<ApiResponse<Object>> signup(dynamic payload) async {
    final Uri url = Uri.parse('${APIRoutes.authServiceUrl}/register');

    try {
      return http.post(url, body: payload, headers: {
        'Content-Type': 'application/json',
      }).then((http.Response response) {
        final Map<String, dynamic> mappedResponse = json.decode(response.body);
        final ApiResponse<SignupResponse> signUpResponseObj =
            ApiResponse.fromJson(mappedResponse, SignupResponse.fromJson);

        logger.i('signup response succesful: ${signUpResponseObj.isSuccess}');
        return signUpResponseObj;
      });
    } catch (error) {
      rethrow;
    }
  }

  static Future<ApiResponse<Object>> validateEmail(dynamic payload) async {
    final Uri url = Uri.parse('${APIRoutes.authServiceUrl}/validate-email');

    try {
      return http.post(url, body: payload, headers: {
        'Content-Type': 'application/json',
      }).then((http.Response response) {
        final Map<String, dynamic> mappedResponse = json.decode(response.body);
        final ApiResponse<Object> validateEmailObj =
            ApiResponse.fromJson(mappedResponse, null);

        logger.i(
            'validate email response succesful: ${validateEmailObj.isSuccess}');
        return validateEmailObj;
      });
    } catch (error) {
      rethrow;
    }
  }

  static Future<ApiResponse<SigninResponse>> validateUser(
      dynamic payload) async {
    final Uri url = Uri.parse('${APIRoutes.authServiceUrl}/confirm-user');

    try {
      return http.post(url, body: payload, headers: {
        'Content-Type': 'application/json',
      }).then((http.Response response) {
        final Map<String, dynamic> mappedResponse = json.decode(response.body);
        final ApiResponse<SigninResponse> validateUserObj =
            ApiResponse.fromJson(mappedResponse, SigninResponse.fromJson);

        logger.i(
            'validate email response succesful: ${validateUserObj.isSuccess}');
        return validateUserObj;
      });
    } catch (error) {
      rethrow;
    }
  }

  static Future<ApiResponse<OtpPasswordResetResponse>> otpPasswordReset(
      dynamic payload) async {
    final Uri url = Uri.parse('${APIRoutes.authServiceUrl}/otp-reset-pass');

    try {
      return http.post(url, body: payload, headers: {
        'Content-Type': 'application/json',
      }).then((http.Response response) {
        final Map<String, dynamic> mappedResponse = json.decode(response.body);
        final ApiResponse<OtpPasswordResetResponse> passwordRestResponse =
            ApiResponse.fromJson(
                mappedResponse, OtpPasswordResetResponse.fromJson);

        logger.i(
            'password reset response succesful: ${passwordRestResponse.isSuccess}');
        return passwordRestResponse;
      });
    } catch (error) {
      rethrow;
    }
  }

  static Future<ApiResponse<GenericResponse>> generateOtp(
      dynamic payload) async {
    final Uri url = Uri.parse('${APIRoutes.authServiceUrl}/generate-token');

    try {
      return http.post(url, body: payload, headers: {
        'Content-Type': 'application/json',
      }).then((http.Response response) {
        final Map<String, dynamic> mappedResponse = json.decode(response.body);
        final ApiResponse<GenericResponse> generateOtpResponse =
            ApiResponse.fromJson(mappedResponse, GenericResponse.fromJson);

        logger.i('otp request succesful: ${generateOtpResponse.isSuccess}');
        return generateOtpResponse;
      });
    } catch (error) {
      rethrow;
    }
  }
}
