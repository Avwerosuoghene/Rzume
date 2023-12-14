import 'package:flutter/material.dart';

class MiscNotifer with ChangeNotifier {
  bool showInfoDialog = true;
  bool overlayVisible = false;
  Color infoColor = Colors.blue;
  String dialogMsg = '';

  void triggerFailure(String msg) {
    infoColor = const Color.fromARGB(255, 212, 51, 0);
    _showDialog(msg);
  }

  void triggerSuccess(String msg) {
    infoColor = const Color.fromARGB(255, 33, 193, 121);
    _showDialog(msg);
  }

  void _showDialog(String msg) {
    overlayVisible = showInfoDialog = true;
    dialogMsg = msg;
    notifyListeners();
  }

  void hideInfoDialog() {
    overlayVisible = showInfoDialog = false;
  }
}
