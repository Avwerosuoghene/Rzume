import 'package:flutter/material.dart';

class StartMessage {
  StartMessage(
      {required this.image,
      required this.title_1,
      this.title_2,
      required this.para});

  final String title_1;
  final String? title_2;
  final String para;
  final String image;
}

class ICustomFormField {
  ICustomFormField({
    required this.formHint,
    required this.formLabel,
    required this.formPreficIcon,
    // required this.validatorLogic,
    required this.showSuffixIcon,
    this.keyboardType,
  });

  final String formHint;
  final String formLabel;
  final String formPreficIcon;
  final TextInputType? keyboardType;
  final bool showSuffixIcon;
  // final String? Function(String? value) validatorLogic;

  String enteredValue = "";

  enteredInputSet(value) {
    enteredValue = value!;
  }
}

class ICustomFormTypes {
  ICustomFormTypes(
      {required this.email,
      required this.password,
      required this.confirmPassword,
      // required this.defaultPass,
      required this.otpInputVal1,
      required this.otpInputVal2,
      required this.otpInputVal3,
      required this.otpInputVal4,
      required this.search});
  final ICustomFormField email;
  final ICustomFormField password;
  final ICustomFormField confirmPassword;
  // final ICustomFormField defaultPass;
  final ICustomFormField otpInputVal1;
  final ICustomFormField otpInputVal2;
  final ICustomFormField otpInputVal3;
  final ICustomFormField otpInputVal4;
  final ICustomFormField search;
}

class IEducation {
  IEducation(
      {required this.id,
      required this.institutionName,
      required this.courseOfStudy,
      required this.grade,
      required this.yeardOfGraduarion});

  final String id;
  final String institutionName;
  final String courseOfStudy;
  final String grade;
  final DateTime yeardOfGraduarion;
}

class IApplication {
  IApplication({
    required this.id,
    required this.position,
    required this.applicationDate,
    required this.documents,
    required this.status,
  });

  final String id;
  final String position;
  final DateTime applicationDate;
  final List<String> documents;
  final String status;
}

class IUser {
  IUser({
    required this.id,
    required this.name,
    required this.userName,
    required this.location,
    required this.education,
    required this.experience,
    required this.skills,
    required this.favorites,
    required this.profilePicture,
    required this.applications,
    required this.bio,
  });
  final String id;
  final String? name;
  final String userName;
  final Map<String, dynamic>? education;
  final String? location;
  final Map<String, dynamic>? experience;
  final Map<String, dynamic>? skills;
  final Map<String, dynamic>? favorites;
  final String? profilePicture;
  final Map<String, dynamic>? applications;
  final String? bio;

  factory IUser.fromJson(Map<String, dynamic> parsedJson) {
    return IUser(
      id: parsedJson['id'] as String,
      name: parsedJson['name'] as String?,
      userName: parsedJson['userName'] as String,
      education: parsedJson['education'] != null
          ? _convertToMapOrString((parsedJson['education']))
          : null,
      location: parsedJson['location'] != null
          ? parsedJson['location'] as String
          : null,
      experience: parsedJson['experience'] != null
          ? _convertToMapOrString(parsedJson['experience'])
          : null,
      skills: parsedJson['skills'] != null
          ? _convertToMapOrString(parsedJson['skills'])
          : null,
      favorites: parsedJson['favorites'] != null
          ? _convertToMapOrString(parsedJson['favorites'])
          : null,
      profilePicture: parsedJson['profilePicture'] != null
          ? parsedJson['profilePicture'] as String
          : null,
      applications: parsedJson['applications'] != null
          ? _convertToMapOrString(parsedJson['applications'])
          : null,
      bio: parsedJson['bio'] != null ? parsedJson['bio'] as String : null,
    );
  }

  static dynamic _convertToMapOrString(dynamic value) {
    if (value is Map<String, dynamic>) {
      return value;
    } else if (value is List<dynamic>) {
      return {for (var item in value) value.indexOf(item).toString(): item};
    } else if (value is String) {
      return {'value': value};
    }
    return null;
  }
}

class ITimer {
  ITimer({
    required this.minutes,
    required this.seconds,
    required this.timer,
  });
  int minutes;
  int seconds;
  int timer;
}

typedef MyBuilder = void Function(
    BuildContext context, void Function() methodFromChild);
