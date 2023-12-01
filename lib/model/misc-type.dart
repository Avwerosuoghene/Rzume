import 'package:flutter/material.dart';

class StartMessage {
  StartMessage(
      {required this.image,
      required this.title_1,
      this.title_2,
      required this.para});

  final String title_1;
  final String? title_2;
  final String para;
  final String image;
}

class ICustomFormField {
  ICustomFormField({
    required this.formHint,
    required this.formLabel,
    required this.formPreficIcon,
    // required this.validatorLogic,
    required this.showSuffixIcon,
    this.keyboardType,
  });

  final String formHint;
  final String formLabel;
  final String formPreficIcon;
  final TextInputType? keyboardType;
  final bool showSuffixIcon;
  // final String? Function(String? value) validatorLogic;

  String enteredValue = "";

  enteredInputSet(value) {
    enteredValue = value!;
  }
}

class ICustomFormTypes {
  ICustomFormTypes(
      {required this.email,
      required this.password,
      required this.confirmPassword,
      required this.defaultPass,
      required this.otpInputVal1,
      required this.otpInputVal2,
      required this.otpInputVal3,
      required this.otpInputVal4,
      required this.search});
  final ICustomFormField email;
  final ICustomFormField password;
  final ICustomFormField confirmPassword;
  final ICustomFormField defaultPass;
  final ICustomFormField otpInputVal1;
  final ICustomFormField otpInputVal2;
  final ICustomFormField otpInputVal3;
  final ICustomFormField otpInputVal4;
  final ICustomFormField search;
}

class ITimer {
  ITimer({
    required this.minutes,
    required this.seconds,
    required this.timer,
  });
  int minutes;
  int seconds;
  int timer;
}

typedef MyBuilder = void Function(BuildContext context, void Function() methodFromChild);

