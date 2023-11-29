import 'package:rzume/config/environment.dart';

class APIRoutes {
  static final String _authService = '${Environment.apiUrl}UsersAuth';

  // Getter using the `get` keyword
  static String get authServiceUrl {
    return _authService;
  }
}
