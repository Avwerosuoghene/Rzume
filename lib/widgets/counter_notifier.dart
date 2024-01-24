import 'dart:async';

import 'package:flutter/material.dart';

import '../model/misc-type.dart';

class CounterNotifier with ChangeNotifier {
  int _count = 0;
  int get count => _count;
  ITimer timerValues = ITimer(minutes: 0, seconds: 0, timer: 0);

  Timer _timer = Timer(Duration.zero, () {});
  var oneSec = const Duration(seconds: 1);
  final int durationInMinutes = 1;
  final int secondsInMinute = 60;

  void startTimer() {
    timerValues.timer = 0;
    timerValues.minutes = 0;
    timerValues.seconds = 0;
    _timer.cancel();

    final int startTime = durationInMinutes;
    timerValues.timer = startTime * secondsInMinute;

    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (timerValues.timer == 0) {
          timer.cancel();
        } else {
          timerValues.timer--;

          timerValues.minutes =
              (timerValues.timer / secondsInMinute).truncate();
          timerValues.seconds = timerValues.timer % secondsInMinute;
          notifyListeners();
        }
      },
    );
  }

  void stopTimer() {
    timerValues.timer = 0;
    timerValues.minutes = 0;
    timerValues.seconds = 0;
    _timer.cancel();
    notifyListeners();
  }

  void increment() {
    _count += 1;
    notifyListeners();
  }
}
