import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:rzume/model/response_payload.dart';
import 'package:rzume/services/api_service.dart';
import 'package:rzume/services/external_services_api_provider.dart';
import 'package:rzume/storage/global_values.dart';

import '../ui/loader.dart';

class HelperAsyncFunctions {
  static Future<bool> getUniversities(BuildContext context) async {
    final APIService apiService = APIService();
    final logger = Logger(
        printer:
            PrettyPrinter(methodCount: 0, errorMethodCount: 3, lineLength: 50));
    ;
    try {
      final JsonArrayReesponse getUniversitiesArray =
          await apiService.sendRequest<dynamic>(
              httpFunction: ExternalServicesAPIProvider.getUniversities,
              payload: null,
              externalService: true,
              context: context);
      context.read<GlobalValues>().setUniverities(getUniversitiesArray);
      return true;
    } catch (error) {
      logger.e(error);
      context.read<GlobalValues>().setUniverities(null);

      // GlobalValues.setUniverities(null);
      return false;
    }
  }
}
