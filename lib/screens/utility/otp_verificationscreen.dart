import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:rzume/model/widgets-arguments.dart';
import 'package:rzume/ui/cus_filled_button.dart';
import 'package:rzume/widgets/auth_page_layout.dart';

import '../../model/user_data.dart';
import '../../model/misc-type.dart';
import '../../model/request_payload.dart';
import '../../services/auth_api_provider.dart';
import '../../services/api_service.dart';
import '../../widgets/counter_notifier.dart';
import '../../ui/loader.dart';
import '../../widgets/helper_functions.dart';

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
  final APIService apiService = APIService();

  final logger = Logger(
      printer:
          PrettyPrinter(methodCount: 0, errorMethodCount: 3, lineLength: 50));

  @override
  void initState() {
    super.initState();
    context.read<CounterNotifier>().startTimer();
  }

  String formatTimeValue(int value) {
    final formattedValue = value < 10 ? '0$value' : value.toString();
    return formattedValue;
  }

  void otpConfirmation() async {
    context.read<CounterNotifier>().stopTimer();
    // _counter.stopTimer();
    _form.currentState!.save();

    String enteredValue = "";

    for (var value in verificationFormFields) {
      enteredValue += value.enteredValue.toString();
    }

    final args =
        ModalRoute.of(context)!.settings.arguments as OtpVerificationScreenArg;

    bool validationResponse = await callValidationFunction(
        args.payload, enteredValue, args.otpValidationFunction);

    if (validationResponse == true && context.mounted) {
      Navigator.pushNamed(context, args.redirectPage);
    }
  }

  Future<bool> callValidationFunction(
      dynamic validationPayload,
      String enteredValue,
      Future<bool> Function(String value) otpValidationFunction) async {
    if (validationPayload is ValidateUserPayload) {
      final ValidateUserPayload validateUserPayload = ValidateUserPayload(
          email: validationPayload.email,
          password: validationPayload.password,
          otpValue: enteredValue);
      bool response = await otpValidationFunction(validateUserPayload.toJson());

      return response;
    }
    if (validationPayload is OtpPasswordResetPayload) {
      final OtpPasswordResetPayload otpPasswordResetPayload =
          OtpPasswordResetPayload(
              email: validationPayload.email,
              password: validationPayload.password,
              otpValue: enteredValue);

      bool response =
          await otpValidationFunction(otpPasswordResetPayload.toJson());

      return response;
    } else {
      return false;
    }
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

  void resendOtpConfirmation() async {
    final args =
        ModalRoute.of(context)!.settings.arguments as OtpVerificationScreenArg;

    try {
      final payload =
          GenerateOtpPayload(email: args.mail, purpose: args.action);
      HelperFunctions.showLoader(context);
      final Map<String, dynamic>? response = await apiService.sendRequest(
          httpFunction: AuthAPIProvider.generateOtp,
          payload: payload.toJson(),
          context: context);

      if (context.mounted) {
        HelperFunctions.closeLoader(context);
      }
      if (response == null && context.mounted) {
        context.read<CounterNotifier>().startTimer();
      }
    } catch (error) {
      if (context.mounted) {
        HelperFunctions.closeLoader(context);
      }
    }
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
