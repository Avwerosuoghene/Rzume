import 'package:flutter/material.dart';
import 'package:rzume/model/enums.dart';
import 'package:rzume/widgets/auth_page_layout.dart';

import '../../../model/widgets-arguments.dart';
import '../../../ui/cus_outline_button.dart';
import '../../../widgets/custom_form.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  void initState() {
    super.initState();
    showErrorMessage();
  }

  Future<void> showErrorMessage() async {
    await Future.delayed(Duration(seconds: 2), () {
      errorMessage = 'Error';
    });
  }

  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    linkedInSignup() {}

    googleSignup() {}

    signIn() {
      // Navigator.pushNamed(context, '/signin');
      Navigator.pushNamed(context, '/create-password');
    }

    Future<void> signup(String email, String password) async {
      final Widget emailScreenText = Column(
        children: [
          Text("Verify Email", style: Theme.of(context).textTheme.titleMedium!),
          Container(
              width: 300,
              margin: const EdgeInsets.only(top: 12, bottom: 15),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Please enter the otp sent to your mail ',
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
          arguments: OtpVerificationScreenArg(screenText: emailScreenText));
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
      FutureBuilder<void>(
        future: showErrorMessage(),
        builder: (context, snapshot) {
          return CustomForm(
            key: UniqueKey(), // Use UniqueKey to force widget rebuild
            formType: FormType.signup,
            submitBtnText: 'Sign up with email',
            errorMessage: errorMessage,
            confirmFunction: signup,
          );
        },
      ),
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
