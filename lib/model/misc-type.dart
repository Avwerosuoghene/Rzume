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
    required this.validatorLogic,
    required this.showSuffixIcon,
    this.keyboardType,
  });

  final String formHint;
  final String formLabel;
  final String formPreficIcon;
  final TextInputType? keyboardType;
  final bool showSuffixIcon;
  final String? Function(String? value) validatorLogic;

  String enteredValue = "";

  enteredInputSet(value) {
    enteredValue = value!;
  }
}
