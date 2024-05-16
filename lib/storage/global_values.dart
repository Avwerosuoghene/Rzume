import 'package:flutter/material.dart';
import 'package:rzume/model/misc-type.dart';
import 'package:rzume/model/response_payload.dart';

class GlobalValues with ChangeNotifier {
  static bool _isLoggedIn = false;
  static String? _userToken;
  static final List<IUniversity> _universitiesObj = [];
  // final List<String> _universities = [];

  static void setLoginStatus(bool isLoggedIn, String userToken) {
    _isLoggedIn = isLoggedIn;
    _userToken = userToken;
  }

  static List<IUniversity> get universitiesObject => _universitiesObj;

  // Setter for _universities
  static set universitiesObject(List<IUniversity> value) {
    _universitiesObj.clear();
    _universitiesObj.addAll(value);
  }

  // void setUniverities(JsonArrayReesponse? extractedUniversitiesArray) {
  //   universities.clear();
  // _universitiesObj.clear();
  //   if (extractedUniversitiesArray == null) {
  //     return;
  //   }

  //   for (var university in extractedUniversitiesArray.data) {
  //     universities.add(university["name"]);
  //     _universitiesObj.add(IUniversity(
  //         name: university["name"], country: university["country"]));
  //   }
  //   notifyListeners();
  // }

  static bool get isLoggedIn {
    return _isLoggedIn;
  }

  static String? get userToken {
    return _userToken;
  }

  // static List<String>? get universities {
  //   return _universities;
  // }
}
