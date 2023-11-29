import 'package:http/http.dart' as http;
import 'package:rzume/model/request_payload.dart';

import '../model/api_routes.dart';

class APIProvider {
  static Future<http.Response> login(String? payload) async {
    final Uri url = Uri.parse('${APIRoutes.authServiceUrl}/login');

    print('here');
    try {
      return http.post(url, body: payload).then((http.Response response) {
        final int statusCode = response.statusCode;

        print('response is ..........  ${response}');
        return response;
      });
    } catch (error) {
      print('Error: $error');
      rethrow;
    }
  }
}
