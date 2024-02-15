import 'package:flutter/material.dart';

import '../ui/loader.dart';

class HelperFunctions {
  static void showLoader(BuildContext context) {
    showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: const Color.fromARGB(133, 0, 0, 0),
            child: const CustomLoader(),
          );
        });
  }

  static void closeLoader(BuildContext context) {
    Navigator.pop(context);
  }

  static String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty || !value.contains('@')) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  static String? stringValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid value';
    }
    return null;
  }
}
