import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ExternalServicesAPIProvider {
  static final logger = Logger(
      printer:
          PrettyPrinter(methodCount: 0, errorMethodCount: 3, lineLength: 50));

  static Future<dynamic> getUniversities(String? arg) async {
    final Uri url = Uri.parse('http://universities.hipolabs.com/search');
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
      });

      print(response);

      final decodedResponse = jsonDecode(response.body);
      logger.i(decodedResponse);
      return response;
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
