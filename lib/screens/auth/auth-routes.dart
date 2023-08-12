import 'package:flutter/material.dart';
import 'package:rzume/screens/auth/signin/signinscreen.dart';
import 'package:rzume/screens/auth/signup/mail-verificationscreen.dart';
import 'package:rzume/screens/auth/signup/signupscreen.dart';
import 'package:rzume/screens/auth/signup/verifiedscreen.dart';

Map<String, Widget Function(BuildContext)> authRoutes = {
  '/signup': (context) => const SignUpScreen(),
  '/mail-verification': (context) => const MailVerificationScreen(),
  '/verified': (context) => const VerifiedScreen(),
  // '/signin': (context) => const SigninScreen()
};
