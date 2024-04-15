import 'package:logger/logger.dart';
import 'package:rzume/model/response_payload.dart';
import 'package:rzume/services/api_service.dart';
import 'package:rzume/services/external_services_api_provider.dart';
import 'package:rzume/storage/global_values.dart';

import '../ui/loader.dart';

class HelperAsyncFunctions {
  static Future<bool> getUniversities() async {
    final APIService apiService = APIService();
    final logger = Logger(
        printer:
            PrettyPrinter(methodCount: 0, errorMethodCount: 3, lineLength: 50));

    if (GlobalValues.universities != null) {
      return true;
    }
    ;
    try {
      final JsonArrayReesponse getUniversitiesArray =
          await apiService.sendRequest<dynamic>(
              httpFunction: ExternalServicesAPIProvider.getUniversities,
              payload: null,
              externalService: true,
              context: null);
      GlobalValues.setUniverities(getUniversitiesArray);
      return true;
    } catch (error) {
      logger.e(error);
      GlobalValues.setUniverities(null);
      return false;
    }
  }
}
