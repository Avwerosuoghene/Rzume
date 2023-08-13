import 'package:flutter/material.dart';
import 'package:rzume/model/widgets-arguments.dart';
import 'package:rzume/ui/cus-filled-button.dart';
import 'package:rzume/widgets/auth-page-layout.dart';

class MailVerificationScreen extends StatelessWidget {
  const MailVerificationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    openMail() {}

    tryAnotherMail() {
      Navigator.pushNamed(context, '/signup');
    }

    final args =
        ModalRoute.of(context)!.settings.arguments as MailVerificationScreenArg;
    final Widget screenText = args.screenText;
    final Widget pageContents = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 150,
        ),
        Image.asset(
          'assets/icons/circle_email.png',
          width: 104,
        ),
        const SizedBox(
          height: 19,
        ),
        screenText,

        const SizedBox(
          height: 30,
        ),
        CusFilledButton(
          buttonWidth: double.infinity,
          buttonText: 'Open email app',
          onPressedFunction: openMail,
        ),

        // comment out later on

        TextButton(
          style: TextButton.styleFrom(),
          onPressed: () {
            Navigator.pushNamed(context, '/verified');
          },
          child: Text(
            'Test Verification',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );

    final Widget footerText = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Did you receive the email? Check your spam filter,'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('or'),
            TextButton(
              style: TextButton.styleFrom(),
              onPressed: tryAnotherMail,
              child: Text(
                'try another email address',
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
