import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../model/response_payload.dart';
import '../widgets/misc_notifier.dart';

class APIService {
  APIService();
  final logger = Logger(
      printer:
          PrettyPrinter(methodCount: 0, errorMethodCount: 3, lineLength: 50));

  Future<Object?> sendRequest(
      {required Future<ApiResponse> Function(String?) httpFunction,
      String? payload,
      required BuildContext context}) async {
    final ApiResponse asyncResponse;
    if (payload != null) {
      try {
        asyncResponse = await httpFunction(payload);
        if (asyncResponse.isSuccess == true) {
          logger.i(asyncResponse.result);

          // Checking for context is mounted is the best way to deal with using
          // build context in asynchronous calls
          if (context.mounted) {
            context.read<MiscNotifer>().triggerSuccess('Success');
          }
          return asyncResponse.result!;
        } else {
          final errorMessage = asyncResponse.errorMessages[0];
          logger.i(errorMessage);
          if (context.mounted) {
            context.read<MiscNotifer>().triggerFailure(errorMessage);
          }

          return null;
        }
      } catch (error) {
        logger.e(error);
        return null;
      }
    } else {
      asyncResponse = await httpFunction(null);
      return {};
    }
  }
}
