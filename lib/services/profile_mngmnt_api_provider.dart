import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../model/api_routes.dart';
import '../model/response_payload.dart';

class ProfileManagementAPIProvider {
  static final logger = Logger(
      printer:
          PrettyPrinter(methodCount: 0, errorMethodCount: 3, lineLength: 50));

  static Future<ApiResponse<GenericResponse>> secondStageUserOnboard(
      String? payload) async {
    final Uri url = Uri.parse('${APIRoutes.profileServiceUrl}/user-onboarding');
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
      logger.e(error);
      rethrow;
    }
  }

  static Future<ApiResponse<GenericResponse>> getUniversities(oad) async {
    final Uri url = Uri.parse('http://universities.hipolabs.com/search');
    try {
      return http.get(url, headers: {
        'Content-Type': 'application/json',
      }).then((http.Response response) {
        final dynamic dynamicResponse = response;

        logger.i('universities returned succesful: ${dynamicResponse}');
        return dynamicResponse;
      });
    } catch (error) {
      logger.e(error);
      rethrow;
    }
  }
}
