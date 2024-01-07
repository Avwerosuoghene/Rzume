import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:rzume/model/enums.dart';
import 'package:rzume/model/response_payload.dart';
import 'package:rzume/widgets/auth_page_layout.dart';
import 'package:rzume/widgets/helper_functions.dart';

import '../../../model/request_payload.dart';
import '../../../model/widgets-arguments.dart';
import '../../../services/api_provider.dart';
import '../../../services/api_service.dart';
import '../../../ui/cus_outline_button.dart';
import '../../../widgets/custom_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final logger = Logger(
      printer:
          PrettyPrinter(methodCount: 0, errorMethodCount: 3, lineLength: 50));
  final APIService apiService = APIService();

  @override
  void initState() {
    super.initState();
    // showErrorMessage();
  }

  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    linkedInSignup() {}

    googleSignup() {}

    signIn() {
      Navigator.pushNamed(context, '/signin');
      // Navigator.pushNamed(context, '/create-password');
    }

    navigateToOtpPage(String email) {
      final Widget emailScreenText = Column(
        children: [
          Text("Verify Email", style: Theme.of(context).textTheme.titleMedium!),
          Container(
              width: 300,
              margin: const EdgeInsets.only(top: 12, bottom: 15),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Please enter the 4 digit code sent to your mail ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(height: 1.5),
                  children: <TextSpan>[
                    TextSpan(
                      text: email,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                    const TextSpan(text: ' to verify your account!'),
                  ],
                ),
              )),
        ],
      );

      Navigator.pushNamed(context, '/otp-verification',
          arguments: OtpVerificationScreenArg(
              screenText: emailScreenText, mail: email));
    }

    Future<void> signup(String email, String password) async {
      final payload = SignupRequest(email: email, password: password);
      HelperFunctions.showLoader(context);
      try {
        final SignupResponse? signupResponse = await apiService.sendRequest(
            httpFunction: APIProvider.signup,
            payload: payload.toJson(),
            context: context);
        logger.i(signupResponse);
        if (context.mounted) {
          HelperFunctions.closeLoader(context);
        }

        if (signupResponse != null && signupResponse.isCreated) {
          // navigateToOtpPage(email);
        }
      } catch (error) {
        if (context.mounted) {
          HelperFunctions.closeLoader(context);
        }
      }
    }

    final Widget pageContents = Column(children: [
      Text('Create your account',
          style: Theme.of(context).textTheme.titleMedium!
          // .copyWith(fontSize: 26, fontWeight: FontWeight.w900),
          ),
      Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 12, bottom: 15),
        child: Text(
          'Please the fill in the form below to create an account',
          style: Theme.of(context).textTheme.bodyMedium!,
          textAlign: TextAlign.center,
        ),
      ),
      CusOutlineButton(
        color: const Color.fromRGBO(16, 96, 166, 1.0),
        icon: 'assets/icons/linkedin_logo.png',
        buttonText: 'Continue with LinkedIn',
        onPressedFunction: linkedInSignup,
      ),
      const SizedBox(
        height: 15,
      ),
      CusOutlineButton(
        color: const Color.fromARGB(255, 3, 26, 46),
        icon: 'assets/icons/google_logo.png',
        buttonText: 'Continue with Google',
        onPressedFunction: googleSignup,
      ),
      Container(
          margin: const EdgeInsets.only(top: 15, bottom: 25),
          child: const Text(
            'Or sign up with your email',
          )),

      CustomForm(
        key: UniqueKey(), // Use UniqueKey to force widget rebuild
        formType: FormType.signup,
        submitBtnText: 'Sign up with email',
        errorMessage: errorMessage,
        confirmFunction: signup,
      ),
      //   },
      // ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Already have have an account?'),
          TextButton(
            style: TextButton.styleFrom(),
            onPressed: signIn,
            child: Text(
              'Login here',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    ]);

    return AuthPageLayout(pageContent: pageContents);
  }
}
