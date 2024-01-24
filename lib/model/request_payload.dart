import 'dart:convert';

class LoginRequestPayload {
  LoginRequestPayload({required this.username, required this.password});

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

class SignupRequestPayload {
  SignupRequestPayload({required this.email, required this.password});

  final String email;
  final String password;

  Map<String, dynamic> toMap() {
    return {'Email': email, 'Password': password};
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

class OtpValidationRequestPayload {
  OtpValidationRequestPayload(
      {required this.email, required this.password, required this.otpValue});

  final String email;
  final String password;
  late String otpValue;

  Map<String, dynamic> toMap() {
    return {'Email': email, 'Password': password, 'OtpValue': otpValue};
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

class ValidateEmailPayload {
  ValidateEmailPayload({required this.email});
  final String email;
  Map<String, dynamic> toMap() {
    return {
      'Email': email,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

class ValidateUserPayload {
  ValidateUserPayload(
      {required this.email, required this.password, this.otpValue});
  final String email;
  final String password;
  final String? otpValue;

  Map<String, dynamic> toMap() {
    return {'Email': email, 'Password': password, 'OtpValue': otpValue};
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

class OtpPasswordResetPayload {
  OtpPasswordResetPayload(
      {required this.email, required this.password, this.otpValue});
  final String email;
  final String password;
  final String? otpValue;

  Map<String, dynamic> toMap() {
    return {'Email': email, 'Password': password, 'OtpValue': otpValue};
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

class GenerateOtpPayload {
  GenerateOtpPayload({required this.email, required this.purpose});
  final String email;
  final String purpose;

  Map<String, dynamic> toMap() {
    return {'Email': email, 'Purpose': purpose};
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
