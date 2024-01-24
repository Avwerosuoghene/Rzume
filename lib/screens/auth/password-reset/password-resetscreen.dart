import 'package:flutter/material.dart';
import 'package:rzume/model/data.dart';
import 'package:rzume/model/misc-type.dart';
import 'package:rzume/model/widgets-arguments.dart';
import 'package:rzume/ui/cus_filled_button.dart';
import 'package:rzume/ui/custom_form_field.dart';
import 'package:rzume/widgets/auth_page_layout.dart';

import '../../../model/request_payload.dart';
import '../../../services/api_provider.dart';
import '../../../services/api_service.dart';
import '../../../widgets/helper_functions.dart';

final ICustomFormField emailFormData = formData.email;

class PasswordResetScreen extends StatelessWidget {
  PasswordResetScreen({super.key});
  final APIService apiService = APIService();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _form = GlobalKey<FormState>();
    var _enteredEmail = '';

    String? emailValidator(String? value) {
      if (value == null || value.trim().isEmpty || !value.contains('@')) {
        return 'Please enter a valid email address';
      }
      return null;
    }

    Future<bool> validateEmail(String email) async {
      final payload = ValidateEmailPayload(email: email);
      HelperFunctions.showLoader(context);
      final Map<String, dynamic>? response = await apiService.sendRequest(
          httpFunction: AuthAPIProvider.validateEmail,
          payload: payload.toJson(),
          context: context);

      if (context.mounted) {
        HelperFunctions.closeLoader(context);
      }
      if (response == null) {
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
      _enteredEmail = emailFormData.enteredValue;

      bool emailValidationResponse = await validateEmail(_enteredEmail);

      if (emailValidationResponse == true && context.mounted) {
        Navigator.pushNamed(context, '/create-password',
            arguments: CreatePasswordArgs(mail: _enteredEmail));
      }
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
              validatorFunction: emailValidator,
              keyboardType: emailFormData.keyboardType,
              onChangeEvent: (value) {
                emailFormData.enteredValue = value;
              }),
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
