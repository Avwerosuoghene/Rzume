import 'package:rzume/model/misc-type.dart';
import 'package:rzume/model/response_payload.dart';

class GlobalValues {
  static bool _isLoggedIn = false;
  static String? _userToken;
  static List<IUniversity>? _universitiesObj;
  static List<String>? _universities;

  static void setLoginStatus(bool isLoggedIn, String userToken) {
    _isLoggedIn = isLoggedIn;
    _userToken = userToken;
  }

  static void setUniverities(JsonArrayReesponse? extractedUniversitiesArray) {
    _universities = [];
    _universitiesObj = [];
    if (extractedUniversitiesArray == null) {
      return;
    }

    extractedUniversitiesArray.data.forEach((university) {
      _universities!.add(university["name"]);
      _universitiesObj!.add(IUniversity(
          name: university["name"], country: university["country"]));
    });
  }

  static bool get isLoggedIn {
    return _isLoggedIn;
  }

  static String? get userToken {
    return _userToken;
  }

  static List<String>? get universities {
    return _universities;
  }
}
