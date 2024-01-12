import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rzume/model/widgets-arguments.dart';
import 'package:rzume/ui/cus_filled_button.dart';
import 'package:rzume/widgets/auth_page_layout.dart';

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

  final CounterNotifier _counter = CounterNotifier();

  @override
  void initState() {
    super.initState();
    context.read<CounterNotifier>().startTimer();
  }

  String formatTimeValue(int value) {
    final formattedValue = value < 10 ? '0$value' : value.toString();
    return formattedValue;
  }

  void otpConfirmation() {
    _counter.stopTimer();
    _form.currentState!.save();

    navigateToAuthScreen();
    Future.delayed(const Duration(seconds: 10), () {
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
            child: const CustomLoader(),
          );
        });
  }

  void resendOtpConfirmation() {
    context.read<CounterNotifier>().startTimer();
  }

  @override
  Widget build(BuildContext context) {
    tryAnotherMail() {
      Navigator.pop(context);
      // Navigator.pushNamed(context, '/signup');
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

          Column(
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
                    '${formatTimeValue(context.watch<CounterNotifier>().timerValues.minutes)} : ${formatTimeValue(context.watch<CounterNotifier>().timerValues.seconds)}',
                  ),
                ],
              ),
              TextButton(
                style: TextButton.styleFrom(),
                onPressed:
                    context.watch<CounterNotifier>().timerValues.timer == 0
                        ? resendOtpConfirmation
                        : null,
                child: Text(
                  'Resend OTP',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color:
                          context.watch<CounterNotifier>().timerValues.timer ==
                                  0
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          //   },
          // ),
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
