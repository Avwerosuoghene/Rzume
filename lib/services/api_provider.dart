import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../model/api_routes.dart';
import '../model/response_payload.dart';

class APIProvider {
  static final logger = Logger(
      printer:
          PrettyPrinter(methodCount: 0, errorMethodCount: 3, lineLength: 50));

  static Future<ApiResponse<SigninResponse>> login(String? payload) async {
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

  static Future<ApiResponse<Object>> signup(String? payload) async {
    final Uri url = Uri.parse('${APIRoutes.authServiceUrl}/register');

    try {
      return http.post(url, body: payload, headers: {
        'Content-Type': 'application/json',
      }).then((http.Response response) {
        final Map<String, dynamic> mappedResponse = json.decode(response.body);
        final ApiResponse<Object> signUpResponseObj =
            ApiResponse.fromJson(mappedResponse, null);

        logger.i('signup response succesful: ${signUpResponseObj.isSuccess}');
        return signUpResponseObj;
      });
    } catch (error) {
      rethrow;
    }
  }
}
