import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rzume/model/misc-type.dart';
import 'package:rzume/model/user_data.dart';
import 'package:rzume/ui/cus_filled_button.dart';
import 'package:rzume/ui/custom_form_field.dart';
import 'package:rzume/widgets/helper_functions.dart';

class OnboardingFirstStage extends StatelessWidget {
  OnboardingFirstStage({super.key, required this.proceedFunction});

  final String? Function(String? value) validator =
      HelperFunctions.stringValidator;
  final void Function(int stepNumber) proceedFunction;

  final List<ICustomFormField> userNameForm = [
    formData.firstname,
    formData.lastname
  ];

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  List<Widget> buildFormFields() {
    return userNameForm.map((formItem) {
      bool isLast = formItem.formHint == userNameForm.last.formHint;

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

  void submitForm() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    _form.currentState!.save();
    proceedFunction(1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('What should we call you?',
            style: Theme.of(context).textTheme.titleMedium!,
            textAlign: TextAlign.start
            // .copyWith(fontSize: 26, fontWeight: FontWeight.w900),
            ),
        const SizedBox(
          height: 40,
        ),
        Form(
            key: _form,
            child: Column(
              children: buildFormFields(),
            )),
        const SizedBox(
          height: 40,
        ),
        CusFilledButton(
          buttonWidth: double.infinity,
          buttonText: "Proceed",
          onPressedFunction: submitForm,
        ),
      ],
    );
  }
}
