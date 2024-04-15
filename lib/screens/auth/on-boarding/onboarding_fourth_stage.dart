import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

class OnboardingFourthStage extends StatefulWidget {
  const OnboardingFourthStage({super.key, required this.proceedFunction});

  final void Function(int stepNumber) proceedFunction;

  @override
  State<OnboardingFourthStage> createState() => _OnboardingFourthStageState();
}

class _OnboardingFourthStageState extends State<OnboardingFourthStage> {
  final String? Function(String? value) validator =
      HelperFunctions.stringValidator;

  final logger = Logger(
      printer:
          PrettyPrinter(methodCount: 0, errorMethodCount: 3, lineLength: 50));

  final List<ICustomFormField> careerForm = [
    formData.company,
    formData.designation
  ];
  late List<String> selectionItems = [];

  final List<IExperience> careeerList = [];

  FocusNode searchFocusNode = FocusNode();
  FocusNode textFieldFocusNode = FocusNode();
  late SingleValueDropDownController _cnt;
  String? selectedIndustry;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool submitFormClicked = false;
  // GlobalKey globalKey = GlobalKey();
  final GlobalKey<CusDropDownButtonState> _customDropDownState =
      GlobalKey<CusDropDownButtonState>();
  final GlobalKey<CustomDatePickerState> _startDatePicker =
      GlobalKey<CustomDatePickerState>();
  final GlobalKey<CustomDatePickerState> _endDatePicker =
      GlobalKey<CustomDatePickerState>();

  void onIndustrySelected(dynamic selectedValue) async {
    setState(() {
      selectedIndustry = selectedValue;
    });
  }

  void onDateSelected(DateTime? selectedValue, String dateType) async {
    if (dateType == "Start") {
      setState(() {
        selectedStartDate = selectedValue;
      });
    } else {
      setState(() {
        selectedEndDate = selectedValue;
      });
    }
  }

  void deletItem(int itemIndex) {
    setState(() {
      careeerList.removeAt(itemIndex);
    });
  }

  void resetFormValues() {
    selectedIndustry = null;
    selectedStartDate = null;
    selectedEndDate = null;
    _customDropDownState.currentState?.resetForm();
    _startDatePicker.currentState?.resetDate();
    _endDatePicker.currentState?.resetDate();
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
    if (!isValid ||
        selectedStartDate == null ||
        selectedEndDate == null ||
        selectedIndustry == null) {
      return;
    }

    _form.currentState!.save();

    careeerList.add(IExperience(
        company: careerForm[0].enteredValue!,
        designation: careerForm[1].enteredValue,
        startDate: selectedStartDate!,
        endDate: selectedEndDate!,
        industry: selectedIndustry!));

    resetFormValues();
  }

  handleProceedCall() {
    if (careeerList.isEmpty) {
      context
          .read<MiscNotifer>()
          .triggerFailure("Please add a valid experience");
      return;
    }
    resetFormValues();
    widget.proceedFunction(1);
  }

  Widget generateCardInfo(IExperience experienceItem) {
    String formatedStartDate = DateFormat.yM().format(experienceItem.startDate);
    String formatedEndDate = DateFormat.yM().format(experienceItem.endDate);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          textAlign: TextAlign.start,
          experienceItem.company,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        Text(
          experienceItem.designation,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: const Color.fromRGBO(0, 0, 0, 0.5)),
        ),
        Text(
          '$formatedStartDate - $formatedEndDate',
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: const Color.fromRGBO(0, 0, 0, 0.5)),
        ),
      ],
    );
  }

  List<Widget> generateCareerList() {
    return careeerList.asMap().entries.map((entry) {
      final index = entry.key;
      final experienceItem = entry.value;
      final cardContent = generateCardInfo(experienceItem);
      return Column(
        children: [
          CustomDisplayCard(
            cardContent: cardContent,
            itemIndex: index,
            deleteFunction: deletItem,
            itemImage: 'assets/icons/career_icon.png',
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      );
    }).toList();
  }

  List<Widget> buildFormFields() {
    return careerForm.map((formItem) {
      bool isLast =
          formItem.formHint == careerForm[careerForm.length - 1].formHint;

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
  void initState() {
    _cnt = SingleValueDropDownController();
    selectionItems = [
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
        Text('What is your career history??',
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
                ...generateCareerList(),
                ...buildFormFields(),
                const SizedBox(
                  height: 20,
                ),
                CustomDatePicker(
                    onSelectDateFunction: (DateTime? selectedValue) {
                      onDateSelected(selectedValue, 'Start');
                    },
                    key: _startDatePicker),
                (submitFormClicked && selectedStartDate == null)
                    ? Container(
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Text(
                          'Please select a start date',
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
                CustomDatePicker(
                    onSelectDateFunction: (DateTime? selectedValue) {
                      onDateSelected(selectedValue, 'End');
                    },
                    key: _endDatePicker),
                (submitFormClicked && selectedEndDate == null)
                    ? Container(
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Text(
                          'Please select an end date',
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
          height: 20,
        ),
        CusDropDownButton(
            onSelectChangeFunction: onIndustrySelected,
            selectionHint: "Select Industry",
            selectionItems: selectionItems,
            searchHint: "Search for industry",
            key: _customDropDownState),
        (submitFormClicked && selectedIndustry == null)
            ? Container(
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Text(
                  'Please select an industry',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.error,
                      fontWeight: FontWeight.w400),
                ),
              )
            : Container(),
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
          buttonText: careeerList.isEmpty ? 'Add' : 'Add another',
          onPressedFunction: () {
            submitForm("Add");
          },
        ),
      ],
    );
  }
}
