import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rzume/model/widgets-arguments.dart';
import 'package:rzume/ui/cus_filled_button.dart';
import 'package:rzume/widgets/auth-page-layout.dart';

import '../../model/data.dart';
import '../../model/misc-type.dart';
import '../../widgets/counter_notifier.dart';
import '../../ui/loader.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final List<ICustomFormField> verificationFormFields = [
    formData.otpInputVal1,
    formData.otpInputVal2,
    formData.otpInputVal3,
    formData.otpInputVal4
  ];

  final CounterModel _counter = CounterModel();

  @override
  void initState() {
    super.initState();

    // for (var i = 1; i < 5; i++) {
    //   verificationFormFields.add(formData.otpInput);
    // }

    _counter.startTimer();
  }

  String formatTimeValue(int value) {
    final formattedValue = value < 10 ? '0$value' : value.toString();
    return formattedValue;
  }

  void otpConfirmation() {
    _counter.stopTimer();
    _form.currentState!
        .save(); // This triggers the onSaved callback for each field

    // Now you can access the values entered in the form
    // For example:
    print('her');
    print(verificationFormFields[1]
        .enteredValue); // Navigator.pushNamed(context, '/verified');

    navigateToAuthScreen();
    Future.delayed(Duration(seconds: 10), () {
      Navigator.pop(context);
    });
  }

  void navigateToAuthScreen() {
    showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: const Color.fromARGB(133, 0, 0, 0),
            child: CustomLoader(),
          );
        });
  }

  void resendOtpConfirmation() {
    _counter.startTimer();
  }

  @override
  Widget build(BuildContext context) {
    tryAnotherMail() {
      Navigator.pushNamed(context, '/signup');
    }

    List<Widget> buildFormFields() {
      // return formList;
      return verificationFormFields.map((formItem) {
        return Row(
          children: [
            SizedBox(
              height: 68,
              width: 64,
              child: TextFormField(
                onChanged: (value) => {
                  if (value.length == 1) {FocusScope.of(context).nextFocus()}
                },
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '0',
                ),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                onSaved: formItem.enteredInputSet,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
          ],
        );
      }).toList();
    }

    final args =
        ModalRoute.of(context)!.settings.arguments as OtpVerificationScreenArg;
    final Widget screenText = args.screenText;
    final Widget pageContents = Center(
      widthFactor: 1.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
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
            height: 15,
          ),
          Form(
            key: _form,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [...buildFormFields()],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          CusFilledButton(
            buttonWidth: double.infinity,
            buttonText: 'Confirm OTP',
            // onPressedFunction: otpConfirmation,
            onPressedFunction: otpConfirmation,
          ),
          const SizedBox(
            height: 10,
          ),

          // Text(
          //   '$formatedMinutes : $formatedSeconds',
          // ),
          ListenableBuilder(
            listenable: _counter,
            builder: (BuildContext context, Widget? child) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Resend OTP in',
                        style: Theme.of(context).textTheme.bodyMedium!,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600),
                        '${formatTimeValue(_counter.timerValues.minutes)} : ${formatTimeValue(_counter.timerValues.seconds)}',
                      ),
                    ],
                  ),
                  TextButton(
                    style: TextButton.styleFrom(),
                    onPressed: _counter.timerValues.timer == 0
                        ? resendOtpConfirmation
                        : null,
                    child: Text(
                      'Resend OTP',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: _counter.timerValues.timer == 0
                              ? Theme.of(context).colorScheme.primary
                              : null,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
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
