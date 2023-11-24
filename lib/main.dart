import 'package:flutter/material.dart';
import 'package:rzume/main-routes.dart';
import 'package:rzume/screens/auth/auth-routes.dart';
import 'package:rzume/screens/auth/signup/signupscreen.dart';

import 'package:rzume/screens/start/splash.dart';
import 'package:rzume/screens/start/startscreen.dart';
import 'package:rzume/screens/utility/otp-verificationscreen.dart';
import 'package:rzume/widgets/start-control.dart';
import 'package:rzume/widgets/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: lightThemeData,
        // darkTheme: darkThemeData,
        routes: routes);
  }
}
