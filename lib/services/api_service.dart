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

  Future<T?> sendRequest<T>(
      {required Future<ApiResponse> Function(String?) httpFunction,
      String? payload,
      required BuildContext context}) async {
    final ApiResponse asyncResponse;
    if (payload != null) {
      try {
        asyncResponse = await httpFunction(payload);
        if (asyncResponse.isSuccess == true) {
          // Checking for context is mounted is the best way to deal with using
          // build context in asynchronous calls

          if (context.mounted) {
            context
                .read<MiscNotifer>()
                .triggerSuccess(asyncResponse.result!.message);
          }
          logger.i('reponse succesfully sent from provider to subscriber');
          return asyncResponse.result!.content! as T;
        } else {
          final errorMessage = asyncResponse.errorMessages[0];
          logger.e('An error occuered with details: $errorMessage');
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
      return null;
    }
  }
}
