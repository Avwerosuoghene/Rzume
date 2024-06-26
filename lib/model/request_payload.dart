import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:rzume/model/enums.dart';
import 'package:rzume/model/misc-type.dart';

class LoginRequestPayload {
  LoginRequestPayload({required this.username, required this.password});

  final String username;
  final String password;

  Map<String, dynamic> toMap() {
    return {
      'Username': username,
      'Password': password,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

class SignupRequestPayload {
  SignupRequestPayload({required this.email, required this.password});

  final String email;
  final String password;

  Map<String, dynamic> toMap() {
    return {'Email': email, 'Password': password};
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

class OtpValidationRequestPayload {
  OtpValidationRequestPayload(
      {required this.email, required this.password, required this.otpValue});

  final String email;
  final String password;
  late String otpValue;

  Map<String, dynamic> toMap() {
    return {'Email': email, 'Password': password, 'OtpValue': otpValue};
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

class ValidateEmailPayload {
  ValidateEmailPayload({required this.email});
  final String email;
  Map<String, dynamic> toMap() {
    return {
      'Email': email,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

class ValidateUserPayload {
  ValidateUserPayload(
      {required this.email, required this.password, this.otpValue});
  final String email;
  final String password;
  final String? otpValue;

  Map<String, dynamic> toMap() {
    return {'Email': email, 'Password': password, 'OtpValue': otpValue};
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

class OtpPasswordResetPayload {
  OtpPasswordResetPayload(
      {required this.email, required this.password, this.otpValue});
  final String email;
  final String password;
  final String? otpValue;

  Map<String, dynamic> toMap() {
    return {'Email': email, 'Password': password, 'OtpValue': otpValue};
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

class OnboardingFirstStagePayload implements ConvertibleToMap {
  OnboardingFirstStagePayload(
      {required this.firstName, required this.lastName});

  final String firstName;
  final String lastName;

  @override
  Map<String, dynamic> toMap() {
    return {'FirstName': firstName, 'LastName': lastName};
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

abstract class ConvertibleToMap {
  Map<String, dynamic> toMap();
}

class OnboardingSecondStagePayload implements ConvertibleToMap {
  OnboardingSecondStagePayload(
      {required this.fileBytes, required this.fileName, required this.fileCat});

  // final PlatformFile file;
  final String fileBytes;
  final String fileName;
  final String fileCat;

  @override
  Map<String, dynamic> toMap() {
    return {'FileBytes': fileBytes, 'FileName': fileName, 'FileCat': fileCat};
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

class OnboardingThirdStagePayload implements ConvertibleToMap {
  OnboardingThirdStagePayload({required this.education});

  // final PlatformFile file;
  final List<IEducation> education;

  @override
  Map<String, dynamic> toMap() {
    return {
      'EducationList': education
          .map((e) => {
                'EducationID': e.id,
                'InstitutionName': e.institutionName,
                'CourseOfStudy': e.courseOfStudy,
                'GraduationDate': e.graduationDate
                    .toIso8601String(), // Convert DateTime to ISO 8601 string
              })
          .toList()
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

class OnboardingFourthStagePayload implements ConvertibleToMap {
  OnboardingFourthStagePayload({required this.experience});

  final List<IExperience> experience;

  @override
  Map<String, dynamic> toMap() {
    return {
      'ExperienceList': experience
          .map((e) => {
                'Industry': e.industry,
                'Company': e.company,
                'Designation': e.designation,
                'StartDate': e.startDate.toIso8601String(),
                'EndDate': e.endDate
                    .toIso8601String(), // Convert DateTime to ISO 8601 string
              })
          .toList()
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

// Convert PlatformFile to a Map
Map<String, dynamic> _fileToJson(PlatformFile file) {
  return {
    'name': file.name,
    'path': file.path,
    'size': file.size,
    'extension': file.extension,
    // Add any other properties you need
  };
}

class OnboardUserPayload<T extends ConvertibleToMap> {
  OnboardUserPayload(
      {required this.stage, required this.onboardUserInfo, required this.mail});
  final int stage;
  final String mail;
  final T onboardUserInfo;

  Map<String, dynamic> toMap() {
    return {
      'OnBoardingStage': stage,
      'OnboardUserPayload': onboardUserInfo.toMap(),
      'UserMail': mail
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

class GenerateOtpPayload {
  GenerateOtpPayload({required this.email, required this.purpose});
  final String email;
  final String purpose;

  Map<String, dynamic> toMap() {
    return {'Email': email, 'Purpose': purpose};
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
