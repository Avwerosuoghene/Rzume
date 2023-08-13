import 'package:flutter/material.dart';
import 'package:rzume/screens/auth/password-reset/password-resetscreen.dart';
import 'package:rzume/screens/auth/signin/signinscreen.dart';
import 'package:rzume/screens/auth/signup/signupscreen.dart';
import 'package:rzume/screens/auth/signup/verifiedscreen.dart';

Map<String, Widget Function(BuildContext)> authRoutes = {
  '/signup': (context) => const SignUpScreen(),
  '/verified': (context) => const VerifiedScreen(),
  '/signin': (context) => const SigninScreen(),
  '/reset-password': (context) => const PasswordResetScreen()
};
