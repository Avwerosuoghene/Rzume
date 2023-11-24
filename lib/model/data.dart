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

ICustomFormTypes formData = ICustomFormTypes(
  email: ICustomFormField(
    formHint: 'Enter email',
    formLabel: 'Email',
    formPreficIcon: 'assets/icons/email.png',
    showSuffixIcon: false,
    keyboardType: TextInputType.emailAddress,
  ),
  password: ICustomFormField(
    formHint: 'Enter password',
    formLabel: 'Password',
    formPreficIcon: 'assets/icons/password.png',
    showSuffixIcon: true,
    keyboardType: TextInputType.visiblePassword,
  ),
  confirmPassword: ICustomFormField(
    formHint: 'Enter password again',
    formLabel: 'Confirm Password',
    formPreficIcon: 'assets/icons/password.png',
    showSuffixIcon: true,
    keyboardType: TextInputType.visiblePassword,
  ),
  defaultPass: ICustomFormField(
    formHint: 'Enter default password',
    formLabel: 'Default Password',
    formPreficIcon: 'assets/icons/password.png',
    showSuffixIcon: true,
    keyboardType: TextInputType.emailAddress,
  ),
  otpInput: ICustomFormField(
    formHint: '0',
    formLabel: '',
    formPreficIcon: '',
    showSuffixIcon: false,
    keyboardType: TextInputType.number,
  ),
);
