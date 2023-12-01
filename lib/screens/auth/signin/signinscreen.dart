import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:rzume/model/enums.dart';
import 'package:rzume/ui/cus_outline-button.dart';
import 'package:rzume/widgets/auth-page-layout.dart';

import '../../../model/request_payload.dart';
import '../../../services/api_provider.dart';
import '../../../services/api_service.dart';
import '../../../ui/loader.dart';
import '../../../widgets/custom_form.dart';

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

  Future<void> signin(String email, String password) async {
    final payload = LoginRequest(username: email, password: password);
    showLoader();
    final response = await apiService.sendRequest(
        httpFunction: APIProvider.login, payload: payload.toJson());
    closeLoader();
    logger.i(response);
  }

  void closeLoader() {
    Navigator.pop(context);
  }

  showLoader() {
    showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: const Color.fromARGB(133, 0, 0, 0),
            child: const CustomLoader(),
          );
        });
  }

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
