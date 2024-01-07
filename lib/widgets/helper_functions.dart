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
}
