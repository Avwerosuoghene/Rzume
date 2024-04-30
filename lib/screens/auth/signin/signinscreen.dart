import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:rzume/model/enums.dart';
import 'package:rzume/model/misc-type.dart';
import 'package:rzume/storage/global_values.dart';
import 'package:rzume/ui/cus_outline_button.dart';
import 'package:rzume/widgets/auth_page_layout.dart';

import '../../../model/request_payload.dart';
import '../../../model/response_payload.dart';
import '../../../model/widgets-arguments.dart';
import '../../../services/auth_api_provider.dart';
import '../../../services/api_service.dart';
import '../../../ui/loader.dart';
import '../../../widgets/custom_form.dart';
import '../../../widgets/helper_functions.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final logger = Logger(
      printer:
          PrettyPrinter(methodCount: 0, errorMethodCount: 3, lineLength: 50));
  final APIService apiService = APIService();

  Future<bool> otpValidationFunction(
    String mailValidationPayload,
  ) async {
    HelperFunctions.showLoader(context);
    try {
      final SigninResponse? signinResponse =
          await apiService.sendRequest<ApiResponse>(
              httpFunction: AuthAPIProvider.validateUser,
              payload: mailValidationPayload,
              context: context);
      if (context.mounted) {
        HelperFunctions.closeLoader(context);
      }

      if (signinResponse == null) {
        return false;
      }

      final IUser user = IUser.fromJson(signinResponse.user);

      if (signinResponse.token != "") {
        if (context.mounted) {
          GlobalValues.setLoginStatus(true, signinResponse.token);
          logger.i('token saved succesfully');
        }
      }
      return true;
    } catch (error) {
      if (context.mounted) {
        HelperFunctions.closeLoader(context);
      }
      return false;
    }
  }

  navigateToOtpPage(String email, String password) {
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

    late ValidateUserPayload validateUserPayload =
        ValidateUserPayload(email: email, password: password);

    Navigator.pushNamed(
      context,
      '/otp-verification',
      arguments: OtpVerificationScreenArg(
          screenText: emailScreenText,
          mail: email,
          otpValidationFunction: otpValidationFunction,
          redirectPage: "/home",
          payload: validateUserPayload,
          action: "Signup"),
    );
  }

  Future<void> signin(String email, String password) async {
    final payload = LoginRequestPayload(username: email, password: password);
    HelperFunctions.showLoader(context);
    final SigninResponse? response = await apiService.sendRequest<ApiResponse>(
        httpFunction: AuthAPIProvider.login,
        payload: payload.toJson(),
        context: context);
    if (context.mounted) {
      HelperFunctions.closeLoader(context);
    }
    if (response == null) {
      return;
    }

    // final IUser user = IUser.fromJson(response!.user);

    if (response.token == "" && !response.emailConfirmed) {
      navigateToOtpPage(email, password);
    }

    if (response.token != "") {
      if (context.mounted) {
        GlobalValues.setLoginStatus(true, response.token);

        logger.i('token saved succesfully');
        Navigator.pushNamed(context, '/home');
      }
    }
  }

  void closeLoader() {
    Navigator.pop(context);
  }

  // showLoader() {
  //   showDialog<String>(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Container(
  //           color: const Color.fromARGB(133, 0, 0, 0),
  //           child: const CustomLoader(),
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    linkedInSignin() {}

    googleSignin() {}

    signup() {
      Navigator.pushNamed(context, '/signup');
    }

    resetPass() {
      Navigator.pushNamed(context, '/reset-password');
    }

    final Widget pageContents = Column(children: [
      Text('Login', style: Theme.of(context).textTheme.titleMedium!
          // .copyWith(fontSize: 26, fontWeight: FontWeight.w900),
          ),
      Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 12, bottom: 15),
        child: Text(
          'Welcome back. Please input your email and password to login',
          style: Theme.of(context).textTheme.bodyMedium!,
          textAlign: TextAlign.center,
        ),
      ),
      CusOutlineButton(
        color: const Color.fromRGBO(16, 96, 166, 1.0),
        icon: 'assets/icons/linkedin_logo.png',
        buttonText: 'Continue with LinkedIn',
        onPressedFunction: linkedInSignin,
      ),
      const SizedBox(
        height: 15,
      ),
      CusOutlineButton(
        color: const Color.fromARGB(255, 3, 26, 46),
        icon: 'assets/icons/google_logo.png',
        buttonText: 'Continue with Google',
        onPressedFunction: googleSignin,
      ),
      Container(
          margin: const EdgeInsets.only(top: 15, bottom: 25),
          child: const Text(
            'Or login with your email',
          )),
      CustomForm(
        formType: FormType.signin,
        submitBtnText: 'Login',
        confirmFunction: signin,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('forgotten your password?'),
          TextButton(
            style: TextButton.styleFrom(),
            onPressed: resetPass,
            child: Text(
              'Reset password',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    ]);

    final Widget footerText = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Don’t have an account? '),
            TextButton(
              style: TextButton.styleFrom(),
              onPressed: signup,
              child: Text(
                'Sign up',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        )
      ],
    );

    return AuthPageLayout(
      pageContent: pageContents,
      footerText: footerText,
    );
  }
}
