import 'package:flutter/material.dart';
import 'package:rzume/model/data.dart';
import 'package:rzume/ui/cus_filled_button.dart';
import 'package:rzume/ui/custom_form_field.dart';
import 'package:rzume/ui/success_dialog.dart';
import 'package:rzume/widgets/auth-page-layout.dart';

import '../../../model/misc-type.dart';

class CreatePasswordScreen extends StatelessWidget {
  const CreatePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _form = GlobalKey<FormState>();
    var _defaultPassword = '';
    var _newPassword = '';
    var _confirmPassword = '';

    late List<ICustomFormField> createPassFormFields = [
      formData.defaultPass,
      formData.password,
      formData.confirmPassword
    ];

    // final ICustomFormField defaultFormValues = formData.password;
    // final ICustomFormField newFormValues = formData.password;
    //     final ICustomFormField confirmPassword = formData.confirmPassword;

    void submitForm() {
      final isValid = _form.currentState!.validate();

      if (!isValid) {
        return;
      }

      _form.currentState!.save();

      showDialog(
          context: context,
          builder: (context) => const SuccessDialog(
                dialogIcon: 'assets/icons/check.png',
                dialogTitle: 'Password reset successful',
                dialogBody:
                    'Please click on the link we just sent to your email.',
              ));
    }

    password(value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your password';
      }
      return null;
    }

    defaultPassword(value) {
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
        if (formItem.formLabel == 'Default Password') {
          validator = defaultPassword;
          onChangeHandlerSet = defaultOnChange;
        } else if (formItem.formLabel == 'Password') {
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
                formPreficIcon: formItem.formPreficIcon,
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
