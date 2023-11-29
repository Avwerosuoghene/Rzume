import 'dart:convert';

class LoginRequest {
  LoginRequest({required this.username, required this.password});

  final String username;
  final String password;

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
