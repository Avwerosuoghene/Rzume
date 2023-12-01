import 'package:flutter/material.dart';

class MiscNotifer with ChangeNotifier {
  bool showInfoDialog = true;
  String test = 'test';

  void triggerInfoDialog() {
    showInfoDialog = false;
    test = 'newValue';
    notifyListeners();
  }
}
