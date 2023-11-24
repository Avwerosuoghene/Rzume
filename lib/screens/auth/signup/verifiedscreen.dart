import 'package:flutter/material.dart';
import 'package:rzume/ui/cus-filled-button.dart';
import 'package:rzume/widgets/auth-page-layout.dart';

class VerifiedScreen extends StatelessWidget {
  const VerifiedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    openHomePage() {}
    final Widget pageContents = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 150,
        ),
        Image.asset(
          'assets/icons/verified_email.png',
          width: 104,
        ),
        const SizedBox(
          height: 19,
        ),
        Text('Verified', style: Theme.of(context).textTheme.titleMedium!
            // .copyWith(fontSize: 26, fontWeight: FontWeight.w900),
            ),
        Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 12, bottom: 15),
            child: Text('You have successfully verified your account',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!)),
        const SizedBox(
          height: 30,
        ),
        CusFilledButton(
          buttonWidth: double.infinity,
          buttonText: 'Proceed to homepage',
          onPressedFunction: openHomePage,
        ),

        // comment out later on
      ],
    );

    return AuthPageLayout(
      pageContent: pageContents,
      showBacknav: false,
    );
  }
}
