import 'dart:convert';
import 'dart:io';

import 'package:chunked_uploader/chunked_uploader.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rzume/model/api_routes.dart';
import 'package:rzume/model/enums.dart';
import 'package:rzume/model/misc-type.dart';
import 'package:rzume/model/request_payload.dart';
import 'package:rzume/model/response_payload.dart';
import 'package:rzume/model/user_data.dart';
import 'package:rzume/services/auth_api_provider.dart';
import 'package:rzume/services/api_service.dart';
import 'package:rzume/services/profile_mngmnt_api_provider.dart';
import 'package:rzume/ui/cus_filled_button.dart';
import 'package:rzume/ui/custom_form_field.dart';
import 'package:rzume/widgets/helper_functions.dart';
import 'package:permission_handler/permission_handler.dart';

class OnboardingSecondStage extends StatelessWidget {
  OnboardingSecondStage({super.key, required this.proceedFunction});

  final String? Function(String? value) validator =
      HelperFunctions.stringValidator;
  final void Function(int stepNumber) proceedFunction;

  FilePickerResult? filePickerResult;
  late String _fileName;
  late PlatformFile _pickedFile;
  File? fileToDisplay;
  final logger = Logger(
      printer:
          PrettyPrinter(methodCount: 0, errorMethodCount: 3, lineLength: 50));
  final APIService apiService = APIService();

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
    Future<void> onFileSelect() async {
      try {
        final BuildContext currentContext = context;

        FilePickerResult? result = await HelperFunctions.filePicker();

        if (result != null) {
          _pickedFile = result.files.first;
          _fileName = _pickedFile.name;
          logger.i(_fileName);
          if (_pickedFile.extension!.toLowerCase() != 'pdf') {
            return;
          }
          File filePath = File(_pickedFile.path!);
          String base64String = await HelperFunctions.encodeFile(filePath);

          if (!context.mounted) {
            return;
          }
          OnboardUserPayload<OnboardingSecondStagePayload> onboarUserPayload =
              OnboardUserPayload<OnboardingSecondStagePayload>(
                  mail: 'kesuion1@gmail.com',
                  stage: 1,
                  onboardUserInfo: OnboardingSecondStagePayload(
                    fileBytes: base64String,
                    fileName: _fileName,
                    fileCat: FileCategory.resume.value,
                  ));
          HelperFunctions.showLoader(currentContext);

       

              // ApiResponse defines the return type of the httpFunction
              await apiService.sendRequest<ApiResponse>(
                  httpFunction:
                      ProfileManagementAPIProvider.secondStageUserOnboard,
                  payload: onboarUserPayload.toJson(),
                  context: currentContext);
          if (context.mounted) {
            HelperFunctions.closeLoader(context);
          }

          fileToDisplay = File(_pickedFile.path.toString());

          logger.i('FileName $_pickedFile');
        }
      } catch (error) {
        logger.e(error);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Please upload your updated CV',
            style: Theme.of(context).textTheme.titleMedium!,
            textAlign: TextAlign.start
            // .copyWith(fontSize: 26, fontWeight: FontWeight.w900),
            ),
        const SizedBox(
          height: 40,
        ),
        GestureDetector(
          onTap: onFileSelect,
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(22),
            dashPattern: const [12, 6],
            strokeWidth: 1,
            color: const Color.fromRGBO(185, 188, 190, 1),
            // padding: EdgeInsets.all(6),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Container(
                height: 154,
                width: double.infinity,
                color: Colors.white,
                padding: const EdgeInsets.all(22),
                alignment: Alignment.bottomCenter,
                child: const Text(
                    'Please upload in pdf., doc., docx. Max of 500kb'),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 73,
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
