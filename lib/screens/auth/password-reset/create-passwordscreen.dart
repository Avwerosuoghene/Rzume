import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:rzume/model/user_data.dart';
import 'package:rzume/model/request_payload.dart';
import 'package:rzume/ui/cus_filled_button.dart';
import 'package:rzume/ui/custom_form_field.dart';
import 'package:rzume/ui/success_dialog.dart';
import 'package:rzume/widgets/auth_page_layout.dart';

import '../../../model/misc-type.dart';
import '../../../model/response_payload.dart';
import '../../../model/widgets-arguments.dart';
import '../../../services/api_provider.dart';
import '../../../services/api_service.dart';
import '../../../widgets/helper_functions.dart';

class CreatePasswordScreen extends StatelessWidget {
  const CreatePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _form = GlobalKey<FormState>();
    var _newPassword = '';
    var _confirmPassword = '';
    final APIService apiService = APIService();
    final logger = Logger(
        printer:
            PrettyPrinter(methodCount: 0, errorMethodCount: 3, lineLength: 50));

    late List<ICustomFormField> createPassFormFields = [
      formData.password,
      formData.confirmPassword
    ];

    final args =
        ModalRoute.of(context)!.settings.arguments as CreatePasswordArgs;

    // Widget createOtpScreentext() {
    //   final Widget emailScreenText = Column(
    //     children: [
    //       Text("Email Sent", style: Theme.of(context).textTheme.titleMedium!),
    //       Container(
    //           width: 300,
    //           margin: const EdgeInsets.only(top: 12, bottom: 15),
    //           child: const Text(
    //             'Please enter the 4 digit code to your mail to initiate password reset',
    //             textAlign: TextAlign.center,
    //           )),
    //     ],
    //   );
    //   return emailScreenText;
    // }

    Future<bool> passwordResetFunction(
      String passwordResetPayload,
    ) async {
      HelperFunctions.showLoader(context);
      try {
        final OtpPasswordResetResponse? passwordResetResponse =
            await apiService.sendRequest(
                httpFunction: AuthAPIProvider.otpPasswordReset,
                payload: passwordResetPayload,
                context: context);
        if (context.mounted) {
          HelperFunctions.closeLoader(context);
        }

        if (passwordResetResponse == null) {
          return false;
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
          Text("Reset Password",
              style: Theme.of(context).textTheme.titleMedium!),
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
                    const TextSpan(text: ' to reset your password!'),
                  ],
                ),
              )),
        ],
      );

      late OtpPasswordResetPayload passwordResetPayload =
          OtpPasswordResetPayload(email: email, password: password);

      Navigator.pushNamed(
        context,
        '/otp-verification',
        arguments: OtpVerificationScreenArg(
            screenText: emailScreenText,
            mail: email,
            otpValidationFunction: passwordResetFunction,
            redirectPage: "/signin",
            payload: passwordResetPayload,
            action: "Password Reset"),
      );
    }

    Future<bool> sendOtpToMail(String email) async {
      final payload =
          GenerateOtpPayload(email: email, purpose: "Password Reset");
      HelperFunctions.showLoader(context);
      final GenericResponse? response = await apiService.sendRequest(
          httpFunction: AuthAPIProvider.generateOtp,
          payload: payload.toJson(),
          context: context);

      if (context.mounted) {
        HelperFunctions.closeLoader(context);
      }
      if (response == null) {
        return false;
      }
      if (response.isSuccess == false) {
        return false;
      }
      return true;
    }

    void submitForm() async {
      final isValid = _form.currentState!.validate();

      if (!isValid) {
        return;
      }

      _form.currentState!.save();

      final enteredMail = args.mail;
      final enteredPassword = createPassFormFields[0].enteredValue;

      try {
        final bool generateOtpResponse = await sendOtpToMail(enteredMail);

        if (generateOtpResponse == true) {
          navigateToOtpPage(enteredMail, enteredPassword);
        }
      } catch (error) {
        if (context.mounted) {
          HelperFunctions.closeLoader(context);
        }
      }

      // showDialog(
      //     context: context,
      //     builder: (context) => const SuccessDialog(
      //           dialogIcon: 'assets/icons/check.png',
      //           dialogTitle: 'Password reset successful',
      //           dialogBody:
      //               'Please click on the link we just sent to your email.',
      //         ));
    }

    password(value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your password';
      }
      return null;
    }

    confimPassword(value) {
      // print(_newPassword);
      if (value == null || value.isEmpty) {
        return 'Please enter your password';
      }
      if (value != _newPassword) {
        return 'Passwords do not match';
      }
      return null;
    }

    defaultOnChange(value) {}

    newPasswordOnChange(value) {
      _newPassword = value;
    }

    List<Widget> buildFormFields() {
      return createPassFormFields.map((formItem) {
        void Function(String? value) onChangeHandlerSet;
        bool isLast = formItem.formHint ==
            createPassFormFields[createPassFormFields.length - 1].formHint;
        String? Function(String? value) validator;
        if (formItem.formLabel == 'Password') {
          validator = password;
          onChangeHandlerSet = newPasswordOnChange;
        } else {
          validator = confimPassword;
          onChangeHandlerSet = defaultOnChange;
        }

        return Column(
          children: [
            CustomFormField(
                formHint: formItem.formHint,
                formLabel: formItem.formLabel,
                formPrefixIcon: formItem.formPrefixIcon,
                inputValue: formItem.enteredInputSet,
                showSuffixIcon: formItem.showSuffixIcon,
                validatorFunction: validator,
                keyboardType: formItem.keyboardType,
                onChangeEvent: onChangeHandlerSet),
            if (!isLast)
              const SizedBox(
                height: 20,
              )
          ],
        );
      }).toList();
    }

    // final List<Widget> createPassFormFieldWidgets =

    final Widget pageContents = Column(
      children: [
        Text('Create new password',
            style: Theme.of(context).textTheme.titleMedium!),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 12, bottom: 15),
          child: Text(
            "We'll send you a password reset link to the email associated with your account",
            style: Theme.of(context).textTheme.bodyMedium!,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Form(
            key: _form,
            child: Column(
              children: [...buildFormFields()],
            )),
        const SizedBox(
          height: 40,
        ),
        CusFilledButton(
          buttonWidth: double.infinity,
          buttonText: "Reset password",
          onPressedFunction: submitForm,
        ),
      ],
    );

    return AuthPageLayout(pageContent: pageContents);
  }
}
