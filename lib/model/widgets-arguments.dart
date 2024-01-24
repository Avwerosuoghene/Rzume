import 'package:flutter/material.dart';
import 'package:rzume/model/request_payload.dart';

class OtpVerificationScreenArg {
  final Widget screenText;
  final String mail;
  final dynamic payload;
  final Future<bool> Function(String value) otpValidationFunction;
  final String redirectPage;
  final String action;

  OtpVerificationScreenArg(
      {required this.screenText,
      required this.mail,
      required this.payload,
      required this.otpValidationFunction,
      required this.redirectPage,
      required this.action});
}

class CreatePasswordArgs {
  // final String email;
  final String mail;

  CreatePasswordArgs({required this.mail});
}
