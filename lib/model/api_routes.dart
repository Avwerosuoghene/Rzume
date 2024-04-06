import 'package:rzume/config/environment.dart';

class APIRoutes {
  static final String _authService = '${Environment.apiUrl}UsersAuth';
  static final String _profileService = '${Environment.apiUrl}UsersProfile';

  // Getter using the `get` keyword
  static String get authServiceUrl {
    return _authService;
  }

  static String get profileServiceUrl {
    return _profileService;
  }
}
