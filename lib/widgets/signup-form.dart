import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rzume/model/data.dart';
import 'package:rzume/model/misc-type.dart';
import 'package:rzume/model/widgets-arguments.dart';
import 'package:rzume/ui/cus-filled-button.dart';

import '../ui/custom_form_field.dart';

class SignupForm extends StatefulWidget {
  SignupForm({super.key});

  @override
  State<SignupForm> createState() {
    return _SignupFormState();
  }
}

class _SignupFormState extends State<SignupForm> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool obscurePass = true;
  var _enteredEmail = '';
  var _enteredPassword = '';
  bool isRememberMeChecked = false;
  final List<CustomForm> signupFormFields = formData;

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

    Navigator.pushNamed(context, '/mail-verification',
        arguments: MailVerificationScreenArg(email: _enteredEmail));
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
              buttonText: 'Signup with email',
              onPressedFunction: submitForm,
            ),
          ),
          // ),
        ],
      ),
    );
  }
}
