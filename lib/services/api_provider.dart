import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rzume/model/request_payload.dart';

import '../model/api_routes.dart';
import '../model/response_payload.dart';

class APIProvider {
  static Future<ApiResponse> login(String? payload) async {
    final Uri url = Uri.parse('${APIRoutes.authServiceUrl}/login');

    try {
      return http.post(url, body: payload, headers: {
        'Content-Type': 'application/json',
      }).then((http.Response response) {
        final Map<String, dynamic> mappedResponse = json.decode(response.body);

        final ApiResponse loginResponseObj =
            ApiResponse.fromJson(mappedResponse);

        return loginResponseObj;
      });
    } catch (error) {
      rethrow;
    }
  }
}
