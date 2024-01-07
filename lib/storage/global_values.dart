class GlobalValues {
  static bool _isLoggedIn = false;
  static String? _userToken;

  static void setLoginStatus(bool isLoggedIn, String userToken) {
    _isLoggedIn = isLoggedIn;
    _userToken = userToken;
  }

  static bool get isLoggedIn {
    return _isLoggedIn;
  }

  static String? get userToken {
    return _userToken;
  }
}
