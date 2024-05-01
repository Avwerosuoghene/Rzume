import 'package:flutter/material.dart';
import 'package:rzume/model/misc-type.dart';
import 'package:rzume/model/response_payload.dart';

class GlobalValues with ChangeNotifier {
  static bool _isLoggedIn = false;
  static String? _userToken;
  final List<IUniversity> _universitiesObj = [];
  final List<String> universities = ['Getting University List...'];

  static void setLoginStatus(bool isLoggedIn, String userToken) {
    _isLoggedIn = isLoggedIn;
    _userToken = userToken;
  }

  void setUniverities(JsonArrayReesponse? extractedUniversitiesArray) {
    universities.clear();
    _universitiesObj.clear();
    if (extractedUniversitiesArray == null) {
      return;
    }

    for (var university in extractedUniversitiesArray.data) {
      universities.add(university["name"]);
      _universitiesObj.add(IUniversity(
          name: university["name"], country: university["country"]));
    }
    notifyListeners();
  }

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
