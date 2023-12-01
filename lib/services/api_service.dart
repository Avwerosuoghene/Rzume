import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../model/response_payload.dart';

class APIService {
  APIService();
  final logger = Logger(
      printer:
          PrettyPrinter(methodCount: 0, errorMethodCount: 3, lineLength: 50));

  // final Function(Object? payload) httpFunction;
  // final Object? payload;

  Future<Object> sendRequest({
    required Future<ApiResponse> Function(String?) httpFunction,
    String? payload,
  }) async {
    final ApiResponse asyncResponse;
    if (payload != null) {
      logger.i(payload);
      try {
        asyncResponse = await httpFunction(payload);
        if (asyncResponse.isSuccess == true) {
          logger.i(asyncResponse.result);
          return asyncResponse.result!;
        } else {
          final errorMessage = asyncResponse.errorMessages[0];
          logger.i(errorMessage);
          return errorMessage;
        }
      } catch (error) {
        logger.e(error);
        return {};
      }
    } else {
      asyncResponse = await httpFunction(null);
      return {};
    }
  }
}
