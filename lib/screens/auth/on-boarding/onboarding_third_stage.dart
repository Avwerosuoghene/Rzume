import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:rzume/model/misc-type.dart';
import 'package:rzume/model/user_data.dart';
import 'package:rzume/ui/cus_dropdown_button.dart';
import 'package:rzume/ui/cus_filled_button.dart';
import 'package:rzume/ui/cus_outline_button.dart';
import 'package:rzume/ui/custom_datepicker.dart';
import 'package:rzume/ui/custom_display_card.dart';
import 'package:rzume/ui/custom_form_field.dart';
import 'package:rzume/widgets/helper_functions.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:rzume/widgets/misc_notifier.dart';

class OnboardingThirdStage extends StatefulWidget {
  const OnboardingThirdStage({super.key, required this.proceedFunction});

  final void Function(int stepNumber) proceedFunction;

  @override
  State<OnboardingThirdStage> createState() => _OnboardingThirdStageState();
}

class _OnboardingThirdStageState extends State<OnboardingThirdStage> {
  final String? Function(String? value) validator =
      HelperFunctions.stringValidator;

  final logger = Logger(
      printer:
          PrettyPrinter(methodCount: 0, errorMethodCount: 3, lineLength: 50));

  final List<ICustomFormField> educationForm = [
    formData.studycourse,
  ];
  late List<String> availableUniversities = [];

  final List<IEducation> selectedEducationList = [];
  late SingleValueDropDownController _cnt;
  String? selectedUniversity;
  DateTime? selectedDate;

  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool submitFormClicked = false;
  final GlobalKey<CusDropDownButtonState> _customDropDownState =
      GlobalKey<CusDropDownButtonState>();
  final GlobalKey<CustomDatePickerState> _customDatePicker =
      GlobalKey<CustomDatePickerState>();

  void onUniversitySelected(String selectedValue) async {
    setState(() {
      selectedUniversity = selectedValue;
    });
  }

  void onDateSelected(DateTime? selectedValue) async {
    setState(() {
      selectedDate = selectedValue;
    });
  }

  void deletItem(int itemIndex) {
    setState(() {
      selectedEducationList.removeAt(itemIndex);
    });
  }

  void resetFormValues() {
    selectedUniversity = null;
    selectedDate = null;
    _customDropDownState.currentState?.resetForm();
    _customDatePicker.currentState?.resetDate();
    _form.currentState?.reset();
    submitFormClicked = false;
  }

  void submitForm(String action) async {
    final isValid = _form.currentState!.validate();

    if (action == "Proceed") {
      handleProceedCall();
    }
    if (action == "Add") {
      handleAddCall(isValid);
    }
  }

  handleAddCall(bool isValid) {
    setState(() {
      submitFormClicked = true;
    });
    if (!isValid || selectedUniversity == null || selectedDate == null) {
      return;
    }

    _form.currentState!.save();

    selectedEducationList.add(IEducation(
        institutionName: selectedUniversity!,
        courseOfStudy: educationForm[0].enteredValue,
        yearOfGraduation: selectedDate!));

    resetFormValues();
  }

  handleProceedCall() {
    if (selectedEducationList.isEmpty) {
      context
          .read<MiscNotifer>()
          .triggerFailure("Please add a valid education");
      return;
    }
    resetFormValues();
    widget.proceedFunction(1);
  }

  Widget generateCardInfo(IEducation educationInfo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          textAlign: TextAlign.start,
          educationInfo.institutionName,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        Text(
          educationInfo.courseOfStudy,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: const Color.fromRGBO(0, 0, 0, 0.5)),
        ),
        Text(
          educationInfo.yearOfGraduation.toIso8601String(),
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: const Color.fromRGBO(0, 0, 0, 0.5)),
        ),
      ],
    );
  }

  List<Widget> generateEducationList() {
    return selectedEducationList.asMap().entries.map((entry) {
      final index = entry.key;
      final educationItem = entry.value;
      final cardContent = generateCardInfo(educationItem);
      return Column(
        children: [
          CustomDisplayCard(
            cardContent: cardContent,
            itemIndex: index,
            deleteFunction: deletItem,
            itemImage: 'assets/icons/education_icon.png',
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      );
    }).toList();
  }

  @override
  void initState() {
    _cnt = SingleValueDropDownController();
    availableUniversities = [
      'A_Item1',
      'A_Item2',
      'A_Item3',
      'A_Item4',
      'B_Item1',
      'B_Item2',
      'B_Item3',
      'B_Item4',
    ];
    super.initState();
  }

  @override
  void dispose() {
    _cnt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('What is your educational history?',
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
              children: [
                ...generateEducationList(),
                CusDropDownButton(
                    onSelectChangeFunction: onUniversitySelected,
                    selectionHint: "Select University",
                    selectionItems: availableUniversities,
                    searchHint: "Search for University",
                    key: _customDropDownState),
                (submitFormClicked && selectedUniversity == null)
                    ? Container(
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Text(
                          'Please select University',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                  fontWeight: FontWeight.w400),
                        ),
                      )
                    : Container(),
                const SizedBox(
                  height: 20,
                ),
                CustomFormField(
                  formHint: formData.studycourse.formHint,
                  formLabel: formData.studycourse.formLabel,
                  formPrefixIcon: formData.studycourse.formPrefixIcon,
                  inputValue: formData.studycourse.enteredInputSet,
                  showSuffixIcon: formData.studycourse.showSuffixIcon,
                  validatorFunction: validator,
                  keyboardType: formData.studycourse.keyboardType,
                  onChangeEvent: (value) {},
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomDatePicker(
                    onSelectDateFunction: onDateSelected,
                    key: _customDatePicker),
                (submitFormClicked && selectedDate == null)
                    ? Container(
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Text(
                          'Please select a date',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                  fontWeight: FontWeight.w400),
                        ),
                      )
                    : Container(),
              ],
            )),
        const SizedBox(
          height: 40,
        ),
        CusFilledButton(
          buttonWidth: double.infinity,
          buttonText: "Proceed",
          onPressedFunction: () {
            submitForm("Proceed");
          },
        ),
        const SizedBox(
          height: 15,
        ),
        CusOutlineButton(
          color: const Color.fromRGBO(16, 96, 166, 1.0),
          // icon: 'assets/icons/linkedin_logo.png',
          buttonText: selectedEducationList.isEmpty ? 'Add' : 'Add another',
          onPressedFunction: () {
            submitForm("Add");
          },
        ),
      ],
    );
  }
}
