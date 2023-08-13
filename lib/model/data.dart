import 'package:flutter/material.dart';

import 'misc-type.dart';


List<StartMessage> screenData = [
  StartMessage(
    image: 'assets/images/organized.png',
    title_1: 'Stay Organized',
    title_2: 'Find Oppurtunites',
    para:
        'Effortlessly track your job applications and never miss an opportunity.',
  ),
  StartMessage(
    image: 'assets/images/target.png',
    title_1: 'Your Job Search Companion',
    para: 'Effortlessly manage your applications and achieve career success.',
  )
];

List<ICustomFormField> formData = [
  ICustomFormField(
    formHint: 'Enter email',
    formLabel: 'Email',
    formPreficIcon: 'assets/icons/email.png',
    showSuffixIcon: false,
    validatorLogic: (value) {
      if (value == null || value.trim().isEmpty || !value.contains('@')) {
        return 'Please enter a valid email address';
      }
      return null;
    },
    keyboardType: TextInputType.emailAddress,
  ),
  ICustomFormField(
    formHint: 'Enter password',
    formLabel: 'Password',
    formPreficIcon: 'assets/icons/password.png',
    showSuffixIcon: true,
    validatorLogic: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your password';
      }
      return null;
    },
    keyboardType: TextInputType.visiblePassword,
  ),
];
