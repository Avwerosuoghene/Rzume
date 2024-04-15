import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:rzume/model/misc-type.dart';
import 'package:rzume/model/response_payload.dart';

class ExternalServicesAPIProvider {
  static final logger = Logger(
      printer:
          PrettyPrinter(methodCount: 0, errorMethodCount: 3, lineLength: 50));

  static Future<JsonArrayReesponse> getUniversities(String? arg) async {
    final Uri url = Uri.parse('http://universities.hipolabs.com/search');
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
      });

      final dynamic decodedResponse = jsonDecode(response.body);
      final JsonArrayReesponse extractedArray =
          JsonArrayReesponse.fromJson(decodedResponse);

      return extractedArray;
    } catch (error) {
      logger.e(error);
      rethrow;
    }
  }
}
