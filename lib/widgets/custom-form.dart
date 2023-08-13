import 'package:flutter/material.dart';
import 'package:rzume/model/data.dart';
import 'package:rzume/model/enums.dart';
import 'package:rzume/model/misc-type.dart';
import 'package:rzume/model/widgets-arguments.dart';
import 'package:rzume/ui/cus-filled-button.dart';

import '../ui/custom_form_field.dart';

class CustomForm extends StatefulWidget {
  const CustomForm(
      {super.key, required this.formType, required this.submitBtnText});

  final FormType formType;
  final String submitBtnText;

  @override
  State<CustomForm> createState() {
    return _CustomFormState();
  }
}

class _CustomFormState extends State<CustomForm> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool obscurePass = true;
  var _enteredEmail = '';
  var _enteredPassword = '';
  bool isRememberMeChecked = false;
  final List<ICustomFormField> signupFormFields = formData;

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  void submitForm() {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    _form.currentState!.save();
    _enteredEmail = signupFormFields[0].enteredValue;
    _enteredPassword = signupFormFields[1].enteredValue;

    final Widget emailScreenText = Column(
      children: [
        Text("Email Verification Sent",
            style: Theme.of(context).textTheme.titleMedium!),
        Container(
            width: 300,
            margin: const EdgeInsets.only(top: 12, bottom: 15),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Please click on the link we just sent ',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(height: 1.5),
                children: <TextSpan>[
                  TextSpan(
                    text: _enteredEmail,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500, color: Colors.black),
                  ),
                  const TextSpan(text: ' to verify your account!'),
                ],
              ),
            )),
      ],
    );

    if (widget.formType == FormType.signup) {
      Navigator.pushNamed(context, '/mail-verification',
          arguments: MailVerificationScreenArg(screenText: emailScreenText));
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> signupFormFieldWidgets =
        signupFormFields.map((formItem) {
      bool isLast = formItem.formHint ==
          signupFormFields[signupFormFields.length - 1].formHint;

      return Column(
        children: [
          CustomFormField(
            formHint: formItem.formHint,
            formLabel: formItem.formLabel,
            formPreficIcon: formItem.formPreficIcon,
            inputValue: formItem.enteredInputSet,
            showSuffixIcon: formItem.showSuffixIcon,
            validatorFunction: formItem.validatorLogic,
            keyboardType: formItem.keyboardType,
          ),
          if (!isLast)
            const SizedBox(
              height: 20,
            )
        ],
      );
    }).toList();

    return Form(
      key: _form,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ...signupFormFieldWidgets,
          if (widget.formType == FormType.signup)
            Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.primary),
                  value: isRememberMeChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isRememberMeChecked = value!;
                    });
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                Text('Remember me',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 14))
              ],
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            // child: SizedBox(
            //   width: double.infinity,
            child: CusFilledButton(
              buttonWidth: double.infinity,
              buttonText: widget.submitBtnText,
              onPressedFunction: submitForm,
            ),
          ),
          // ),
        ],
      ),
    );
  }
}
