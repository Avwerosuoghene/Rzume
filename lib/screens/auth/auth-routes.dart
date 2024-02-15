import 'package:flutter/material.dart';
import 'package:rzume/screens/auth/on-boarding/onboardingscreen.dart';
import 'package:rzume/screens/auth/password-reset/create-passwordscreen.dart';
import 'package:rzume/screens/auth/password-reset/password-resetscreen.dart';
import 'package:rzume/screens/auth/signin/signinscreen.dart';
import 'package:rzume/screens/auth/signup/signupscreen.dart';
import 'package:rzume/screens/auth/signup/verifiedscreen.dart';

Map<String, Widget Function(BuildContext)> authRoutes = {
  '/signup': (context) => SignUpScreen(),
  '/verified': (context) => const VerifiedScreen(),
  '/signin': (context) => const SigninScreen(),
  '/reset-password': (context) => PasswordResetScreen(),
  '/create-password': (context) => const CreatePasswordScreen(),
  '/onboarding': (context) => const OnboardingScreen()
};
