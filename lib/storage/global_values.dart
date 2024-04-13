import 'package:rzume/model/misc-type.dart';

class GlobalValues {
  static bool _isLoggedIn = false;
  static String? _userToken;
  static List<IUniversity>? _universities;

  static void setLoginStatus(bool isLoggedIn, String userToken) {
    _isLoggedIn = isLoggedIn;
    _userToken = userToken;
  }

  static void setUniverities(List<dynamic> unOrganizedUniversities) {
    _universities = unOrganizedUniversities.map((university) {
      return IUniversity(name: university.name, country: university.country);
    }).toList();
  }

  static bool get isLoggedIn {
    return _isLoggedIn;
  }

  static String? get userToken {
    return _userToken;
  }

  static List<IUniversity>? get university {
    return _universities;
  }
}
