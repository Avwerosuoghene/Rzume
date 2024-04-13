import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:rzume/model/response_payload.dart';
import 'package:rzume/screens/auth/on-boarding/onboarding_first_stage.dart';
import 'package:rzume/screens/auth/on-boarding/onboarding_fourth_stage.dart';
import 'package:rzume/screens/auth/on-boarding/onboarding_second_stage.dart';
import 'package:rzume/screens/auth/on-boarding/onboarding_third_stage.dart';
import 'package:rzume/services/api_service.dart';
import 'package:rzume/services/external_services_api_provider.dart';

import '../../../widgets/auth_page_layout.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final APIService apiService = APIService();

    static final logger = Logger(
      printer:
          PrettyPrinter(methodCount: 0, errorMethodCount: 3, lineLength: 50));

  @override
  void initState() {
    super.initState();

    getCountries();
  }

  void getCountries() async {
    try {
      final dynamic getUniversities = await apiService.sendRequest<dynamic>(
          httpFunction: ExternalServicesAPIProvider.getUniversities,
          payload: null,
          externalService: true,
          context: null);
      logger.e(getUniversities);
    } catch (error) {
      print(error);
    }
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
    final pageContent =
        // OnboardingFirstStage(proceedFunction: proceedToNextStep);
        OnboardingThirdStage(proceedFunction: proceedToNextStep);
    return AuthPageLayout(
      pageContent: pageContent,
      showBacknav: true,
      crossAxisAlignment: CrossAxisAlignment.start,
      backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
    );
  }
}
