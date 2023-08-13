import 'package:flutter/material.dart';
import 'package:rzume/model/data.dart';
import 'package:rzume/model/misc-type.dart';
import 'package:rzume/model/widgets-arguments.dart';
import 'package:rzume/ui/cus-filled-button.dart';
import 'package:rzume/ui/custom_form_field.dart';
import 'package:rzume/widgets/auth-page-layout.dart';

final ICustomFormField emailFormData = formData[0];

class PasswordResetScreen extends StatelessWidget {
  const PasswordResetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _form = GlobalKey<FormState>();
    var _enteredEmail = '';

    void submitForm() {
      final isValid = _form.currentState!.validate();

      if (!isValid) {
        return;
      }

      _form.currentState!.save();
      _enteredEmail = emailFormData.enteredValue;

      final Widget emailScreenText = Column(
        children: [
          Text("Email Sent", style: Theme.of(context).textTheme.titleMedium!),
          Container(
              width: 300,
              margin: const EdgeInsets.only(top: 12, bottom: 15),
              child: const Text(
                'Please click on the link we just sent to your email.',
                textAlign: TextAlign.center,
              )),
        ],
      );

      Navigator.pushNamed(context, '/mail-verification',
          arguments: MailVerificationScreenArg(screenText: emailScreenText));
    }

    final Widget pageContents = Column(
      children: [
        Text('Reset password', style: Theme.of(context).textTheme.titleMedium!),
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
          autovalidateMode: AutovalidateMode.always,
          child: CustomFormField(
            formHint: emailFormData.formHint,
            formLabel: emailFormData.formLabel,
            formPreficIcon: emailFormData.formPreficIcon,
            inputValue: emailFormData.enteredInputSet,
            showSuffixIcon: emailFormData.showSuffixIcon,
            validatorFunction: emailFormData.validatorLogic,
            keyboardType: emailFormData.keyboardType,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        CusFilledButton(
          buttonWidth: double.infinity,
          buttonText: "Send email",
          onPressedFunction: submitForm,
        ),
      ],
    );
    return AuthPageLayout(pageContent: pageContents);
  }
}
