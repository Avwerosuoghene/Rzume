import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../model/response_payload.dart';
import '../widgets/misc_notifier.dart';

// typedef Future<T> MyFunction<T>([String? argument]);

class APIService {
  APIService();
  final logger = Logger(
      printer:
          PrettyPrinter(methodCount: 0, errorMethodCount: 3, lineLength: 50));

  Future<dynamic> sendRequest<T>(
      {required Future<T> Function(String? arg) httpFunction,
      String? payload,
      required BuildContext? context,
      bool externalService = false}) async {
    final dynamic asyncResponse;

    if (payload != null) {
      try {
        if (externalService == true) {
          asyncResponse = await httpFunction(payload);
          logger.i('reponse succesfully sent from provider to subscriber');
          return asyncResponse;
        }
        asyncResponse = await (httpFunction(payload)) as ApiResponse;
        if (asyncResponse.isSuccess == true) {
          // Checking for context is mounted is the best way to deal with using
          // build context in asynchronous calls

          if (context!.mounted) {
            context
                .read<MiscNotifer>()
                .triggerSuccess(asyncResponse.result!.message);
          }
          logger.i('reponse succesfully sent from provider to subscriber');
          return asyncResponse.result!.content! as T;
        } else {
          final errorMessage = asyncResponse.errorMessages[0];
          logger.e('An error occuered with details: $errorMessage');
          if (context!.mounted) {
            context!.read<MiscNotifer>().triggerFailure(errorMessage);
          }

          return null;
        }
      } catch (error) {
        logger.e(error);
        return null;
      }
    } else {
      try {
        if (externalService == true) {
          asyncResponse = await httpFunction(null);
          logger.i('reponse succesfully sent from provider to subscriber');
          return asyncResponse as T;
        }
      } catch (error) {
        logger.e(error);
        return null;
      }
      // asyncResponse = await httpFunction(null);
      // return null;
    }
  }
}
