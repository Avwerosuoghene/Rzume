import 'package:flutter/material.dart';
import 'package:rzume/screens/auth/on-boarding/onboarding_first_stage.dart';
import 'package:rzume/screens/auth/on-boarding/onboarding_fourth_stage.dart';
import 'package:rzume/screens/auth/on-boarding/onboarding_second_stage.dart';
import 'package:rzume/screens/auth/on-boarding/onboarding_third_stage.dart';

import '../../../widgets/auth_page_layout.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty || !value.contains('@')) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String enteredValue = "";

  enteredInputSet(value) {
    enteredValue = value!;
  }

  proceedToNextStep(int stepNumber) {}

  @override
  Widget build(BuildContext context) {
    final pageContent =
        // OnboardingFirstStage(proceedFunction: proceedToNextStep);
        OnboardingSecondStage(proceedFunction: proceedToNextStep);
    return AuthPageLayout(
      pageContent: pageContent,
      showBacknav: true,
      crossAxisAlignment: CrossAxisAlignment.start,
      backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
    );
  }
}
