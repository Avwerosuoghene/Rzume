import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:rzume/model/misc-type.dart';
import 'package:rzume/model/request_payload.dart';
import 'package:rzume/model/user_data.dart';
import 'package:rzume/storage/global_values.dart';
import 'package:rzume/ui/cus_dropdown_button.dart';
import 'package:rzume/ui/cus_filled_button.dart';
import 'package:rzume/ui/cus_outline_button.dart';
import 'package:rzume/ui/custom_datepicker.dart';
import 'package:rzume/ui/custom_display_card.dart';
import 'package:rzume/ui/custom_form_field.dart';
import 'package:rzume/widgets/helper_functions.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:rzume/widgets/helper_functions_async.dart';
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
  List<String>? availableUniversities = [];

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
  bool proceedToNext = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // This ensures the build is complete before trying to update a state
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setUniversitiesList();
    });
    // setUniversitiesList();
  }

  setUniversitiesList() async {
    if (GlobalValues.universities != null) {
      setState(() {
        availableUniversities = GlobalValues.universities;
      });
      return;
    }

    HelperFunctions.showLoader(context);
    bool isSuccess = await HelperAsyncFunctions.getUniversities();
    if (context.mounted) {
      HelperFunctions.closeLoader(context);
    }
    if (!isSuccess) {
      context.read<MiscNotifer>().triggerFailure("An error occured");
      return;
    }

    setState(() {
      availableUniversities = GlobalValues.universities;
    });
  }

  @override
  void dispose() {
    _cnt.dispose();
    super.dispose();
  }

  List<Widget> buildFormFields() {
    return educationForm.map((formItem) {
      bool isLast =
          formItem.formHint == educationForm[educationForm.length - 1].formHint;

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

  OnboardUserPayload<OnboardingThirdStagePayload> generateThirdStagePayload() {
    return OnboardUserPayload(
        stage: 2,
        onboardUserInfo:
            OnboardingThirdStagePayload(education: selectedEducationList),
        mail: 'kesuion1@gmail.com');
  }

  Future initiateThirdStageRequest(BuildContext currentContext) async {
    OnboardUserPayload<OnboardingThirdStagePayload> onboarUserPayload =
        generateThirdStagePayload();
    HelperFunctions.showLoader(currentContext);
  }

  isContinuation(bool isSubmissionInvalid) {
    setState(() {
      submitFormClicked = true;
    });
    if (isSubmissionInvalid) {
      context
          .read<MiscNotifer>()
          .triggerFailure("Please add a valid education");
      return;
    }

    _form.currentState!.save();

    selectedEducationList.add(IEducation(
        institutionName: selectedUniversity!,
        courseOfStudy: educationForm[0].enteredValue,
        graduationDate: selectedDate!));
  }

  Widget generateCardInfo(IEducation educationInfo) {
    String formattedDate = DateFormat.yM().format(educationInfo.graduationDate);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          textAlign: TextAlign.start,
          educationInfo.institutionName,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        Text(
          educationInfo.courseOfStudy,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: const Color.fromRGBO(0, 0, 0, 0.5)),
        ),
        Text(
          formattedDate,
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
      return proceedToNext == false
          ? Column(
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
            )
          : Container();
    }).toList();
  }

  @override
  void initState() {
    _cnt = SingleValueDropDownController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void submitForm(String action) async {
      final isFormValid = _form.currentState!.validate();

      final bool isSubmissionInvalid =
          !isFormValid || selectedUniversity == null || selectedDate == null;

      if (action == "Proceed") {
        isContinuation(isSubmissionInvalid);
        proceedToNext = true;
        await initiateThirdStageRequest(context);
        widget.proceedFunction(1);
        resetFormValues();
      }
      if (action == "Add") {
        isContinuation(isSubmissionInvalid);
        resetFormValues();
      }
    }

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
                    selectionItems: availableUniversities != null
                        ? availableUniversities as List<String>
                        : null,
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
                ...buildFormFields(),
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
          buttonText: selectedEducationList.isNotEmpty && proceedToNext != true
              ? 'Add another'
              : 'Add',
          onPressedFunction: () {
            submitForm("Add");
          },
        ),
      ],
    );
  }
}
