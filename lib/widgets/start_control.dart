import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:rzume/screens/start/splash.dart';
import 'package:rzume/screens/start/startscreen.dart';
import '../model/enums.dart';

class StartControl extends StatefulWidget {
  const StartControl({super.key});
  @override
  State<StartControl> createState() {
    return _StartControlState();
  }
}

class _StartControlState extends State<StartControl> {
  Widget _activeScreen = const SplashScreen();

  @override
  void initState() {
    setTimeout();
    super.initState();
  }

  void setTimeout() async {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _activeScreen = const StartScreen();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: AnimatedSwitcher(
        duration: const Duration(seconds: 3),
        child: _activeScreen,
      )),
    );
  }
}
