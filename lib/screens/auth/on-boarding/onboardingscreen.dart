import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:rzume/screens/auth/on-boarding/onboarding_fourth_stage.dart';
import 'package:rzume/screens/auth/on-boarding/onboarding_third_stage.dart';

import 'package:rzume/services/api_service.dart';
import 'package:rzume/storage/global_values.dart';
import 'package:rzume/widgets/helper_functions_async.dart';

import '../../../widgets/auth_page_layout.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final APIService apiService = APIService();
  late GlobalValues globalValues;

  static final logger = Logger(
      printer:
          PrettyPrinter(methodCount: 0, errorMethodCount: 3, lineLength: 50));

  @override
  void initState() {
    super.initState();
  }

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
    // globalValues = Provider.of<GlobalValues>(context);

    // if (globalValues.universities.length <= 1) {
    //   HelperAsyncFunctions.getUniversities(context);
    // }

    final pageContent =
        OnboardingThirdStage(proceedFunction: proceedToNextStep);
    return AuthPageLayout(
      pageContent: pageContent,
      showBacknav: true,
      crossAxisAlignment: CrossAxisAlignment.start,
      backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
    );
  }
}
