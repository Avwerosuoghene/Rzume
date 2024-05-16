import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:rzume/model/misc-type.dart';
import 'package:rzume/model/response_payload.dart';
import 'package:rzume/services/api_service.dart';
import 'package:rzume/services/external_services_api_provider.dart';
import 'package:rzume/storage/global_values.dart';

class HelperAsyncFunctions {
  static Future<List<String>> getUniversities(
      BuildContext context, String universityName) async {
    final APIService apiService =APIService();
    final logger = Logger(
        printer:
            PrettyPrinter(methodCount: 0, errorMethodCount: 3, lineLength: 50));

    try {
      final JsonArrayReesponse? extractedUniversities =
          await apiService.sendRequest<dynamic>(
              query: ISearchQuery(searchParam: 'benin'),
              httpFunction: ExternalServicesAPIProvider.getUniversities,
              payload: null,
              externalService: true,
              context: context);

      if (extractedUniversities == null) {
        return [];
      }
      final List<String> universities = [];
      final List<IUniversity> universitiesObj = [];
      for (var university in extractedUniversities.data) {
        universities.add(university["name"]);
        universitiesObj.add(IUniversity(
            name: university["name"], country: university["country"]));
      }

      GlobalValues.universitiesObject = universitiesObj;

      return universities;
    } catch (error) {
      logger.e(error);

      return [];
    }
  }
}
