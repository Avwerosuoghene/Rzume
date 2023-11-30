import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rzume/model/request_payload.dart';

import '../model/api_routes.dart';
import '../model/response_payload.dart';

class APIProvider {
  static Future<http.Response> login(String? payload) async {
    final Uri url = Uri.parse('${APIRoutes.authServiceUrl}/login');

    print('here');
    try {
      return http.post(url, body: payload, headers: {
        'Content-Type': 'application/json',
      }).then((http.Response response) {
        final int statusCode = response.statusCode;
        final Map<String, dynamic> mappedResponse = json.decode(response.body);

        final LoginResponse convertedResponse =
            LoginResponse.fromJson(mappedResponse);

        // User user = User.fromJson(jsonMap);
        print('response is ..........  ${convertedResponse}');
        return response;
      });
    } catch (error) {
      print('Error: $error');
      rethrow;
    }
  }
}
