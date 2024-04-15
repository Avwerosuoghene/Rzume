import 'package:flutter/material.dart';
import 'package:rzume/model/user_data.dart';
import 'package:rzume/model/enums.dart';
import 'package:rzume/model/misc-type.dart';
import 'package:rzume/model/widgets-arguments.dart';
import 'package:rzume/ui/cus_filled_button.dart';
import 'package:rzume/widgets/helper_functions.dart';

import '../ui/custom_form_field.dart';

class CustomForm extends StatefulWidget {
  const CustomForm(
      {super.key,
      required this.formType,
      required this.submitBtnText,
      this.errorMessage,
      required this.confirmFunction});

  final FormType formType;
  final String submitBtnText;
  final String? errorMessage;
  final Future<void> Function(String email, String password) confirmFunction;

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
  final List<ICustomFormField> signupFormFields = [
    formData.email,
    formData.password
  ];

  late String? Function(String? value) validator;

  // String? passwordValidator(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please enter your password';
  //   }
  //   return null;
  // }

  // String? emailValidator(String? value) {
  //   if (value == null || value.trim().isEmpty || !value.contains('@')) {
  //     return 'Please enter a valid email address';
  //   }
  //   return null;
  // }

  void submitForm() {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    _form.currentState!.save();
    _enteredEmail = signupFormFields[0].enteredValue;
    _enteredPassword = signupFormFields[1].enteredValue;

    widget.confirmFunction(_enteredEmail, _enteredPassword);

  }

  List<Widget> buildFormFields() {
    return signupFormFields.map((formItem) {
      bool isLast = formItem.formHint ==
          signupFormFields[signupFormFields.length - 1].formHint;

      if (formItem.formLabel == 'Password') {
        validator = HelperFunctions.passwordValidator;
      } else {
        validator = HelperFunctions.emailValidator;
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
            onChangeEvent: (value) {},
          ),
          if (!isLast)
            const SizedBox(
              height: 20,
            )
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // signupFormFieldWidgets =

    return Form(
      key: _form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ...buildFormFields(),
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

          if (widget.errorMessage != null)
            Center(
              // margin: const EdgeInsets.only(top: 10),
              child: Container(
                margin: const EdgeInsets.only(top: 10, bottom: 5),
                child: Text(
                  widget.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
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
