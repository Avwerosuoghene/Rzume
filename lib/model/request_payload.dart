import 'dart:convert';

class LoginRequest {
  LoginRequest({required this.username, required this.password});

  final String username;
  final String password;

  Map<String, dynamic> toMap() {
    return {
      'Username': username,
      'Password': password,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

class SignupRequest {
  SignupRequest({required this.email, required this.password});

  final String email;
  final String password;

  Map<String, dynamic> toMap() {
    return {
      'Email': email,
      'Password': password,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
