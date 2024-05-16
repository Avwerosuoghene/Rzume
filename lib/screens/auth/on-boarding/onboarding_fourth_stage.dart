import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:rzume/model/mids_data.dart';
import 'package:rzume/model/misc-type.dart';
import 'package:rzume/model/request_payload.dart';
import 'package:rzume/model/response_payload.dart';
import 'package:rzume/model/user_data.dart';
import 'package:rzume/services/api_service.dart';
import 'package:rzume/services/profile_mngmnt_api_provider.dart';
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
  late List<String> selectionItems;

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
  bool proceedToNext = false;
  final APIService apiService = APIService();

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

  OnboardUserPayload<OnboardingFourthStagePayload>
      generateFourthStagePayload() {
    return OnboardUserPayload(
        stage: 3,
        onboardUserInfo: OnboardingFourthStagePayload(experience: careeerList),
        mail: 'kesuion1@gmail.com');
  }

  Future initiateFourthStageRequest(BuildContext currentContext) async {
    OnboardUserPayload<OnboardingFourthStagePayload> onboarUserPayload =
        generateFourthStagePayload();

    try {
      HelperFunctions.showLoader(currentContext);

      // final GenericResponse? onboardingResponse =
      GenericResponse? requestResponse =
          await apiService.sendRequest<GenericResponse>(
              httpFunction: ProfileManagementAPIProvider.onboardUser,
              payload: onboarUserPayload.toJson(),
              context: currentContext);
      if (requestResponse?.isSuccess == true) {
        careeerList.clear();
      }
      if (context.mounted) {
        HelperFunctions.closeLoader(context);
      }
    } catch (error) {
      logger.e(error);
    }
  }

  bool onIndustrySearchEntered(dynamic item, String searchValue) {
    return item.value
        .toString()
        .toLowerCase()
        .contains(searchValue.toLowerCase());
  }

  void submitForm(String action) async {
    final isFormValid = _form.currentState!.validate();

    final bool isSubmissionInvalid = !isFormValid ||
        selectedStartDate == null ||
        selectedEndDate == null ||
        selectedIndustry == null;

    if (action == "Proceed") {
      final bool validFormData = isContinuation(isSubmissionInvalid);
      if (!validFormData) {
        return;
      }
      proceedToNext = true;
      await initiateFourthStageRequest(context);
      widget.proceedFunction(1);

      careeerList.clear();
      resetFormValues();
    }
    if (action == "Add") {
      proceedToNext = false;
      final bool validFormData = isContinuation(isSubmissionInvalid);
      if (!validFormData) {
        return;
      }
      resetFormValues();
    }
  }

  bool isContinuation(bool isSubmissionInvalid) {
    setState(() {
      submitFormClicked = true;
    });

    if (isSubmissionInvalid && careeerList.isEmpty) {
      context
          .read<MiscNotifer>()
          .triggerFailure("Please add a valid experience");
      return false;
    }

    if (isSubmissionInvalid) {
      return true;
    }

    _form.currentState!.save();

    careeerList.add(IExperience(
        company: careerForm[0].enteredValue!,
        designation: careerForm[1].enteredValue,
        startDate: selectedStartDate!,
        endDate: selectedEndDate!,
        industry: selectedIndustry!));

    // ();
    return true;
  }

  handleProceedCall(bool isSubmissionInvalid, bool proceed) {
    if (isSubmissionInvalid) {
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
          overflow: TextOverflow.ellipsis,
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
      return proceedToNext == false
          ? Column(
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
            )
          : Container();
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
    selectionItems = MiscData.getIndustryList();
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
            searchInputHandler: onIndustrySearchEntered,
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
          buttonText: careeerList.isNotEmpty && proceedToNext != true
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
