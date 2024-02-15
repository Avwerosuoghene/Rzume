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
  studycourse: ICustomFormField(
    formHint: 'Enter course of study',
    formLabel: 'Study course',
    formPrefixIcon: '',
    showSuffixIcon: false,
    keyboardType: TextInputType.text,
  ),
  company: ICustomFormField(
    formHint: 'Enter company name',
    formLabel: 'Company',
    formPrefixIcon: '',
    showSuffixIcon: false,
    keyboardType: TextInputType.text,
  ),
  designation: ICustomFormField(
    formHint: 'Enter title',
    formLabel: 'Designation',
    formPrefixIcon: '',
    showSuffixIcon: false,
    keyboardType: TextInputType.text,
  ),
  firstname: ICustomFormField(
    formHint: 'Enter first name',
    formLabel: 'Firstname',
    formPrefixIcon: '',
    showSuffixIcon: false,
    keyboardType: TextInputType.text,
  ),
  lastname: ICustomFormField(
    formHint: 'Enter last name',
    formLabel: 'Lastname',
    formPrefixIcon: '',
    showSuffixIcon: false,
    keyboardType: TextInputType.text,
  ),
  email: ICustomFormField(
    formHint: 'Enter email',
    formLabel: 'Email',
    formPrefixIcon: 'assets/icons/email.png',
    showSuffixIcon: false,
    keyboardType: TextInputType.emailAddress,
  ),
  password: ICustomFormField(
    formHint: 'Enter password',
    formLabel: 'Password',
    formPrefixIcon: 'assets/icons/password.png',
    showSuffixIcon: true,
    keyboardType: TextInputType.visiblePassword,
  ),
  confirmPassword: ICustomFormField(
    formHint: 'Enter password again',
    formLabel: 'Confirm Password',
    formPrefixIcon: 'assets/icons/password.png',
    showSuffixIcon: true,
    keyboardType: TextInputType.visiblePassword,
  ),
  otpInputVal1: ICustomFormField(
    formHint: '0',
    formLabel: '',
    formPrefixIcon: '',
    showSuffixIcon: false,
    keyboardType: TextInputType.number,
  ),
  otpInputVal2: ICustomFormField(
    formHint: '0',
    formLabel: '',
    formPrefixIcon: '',
    showSuffixIcon: false,
    keyboardType: TextInputType.number,
  ),
  otpInputVal3: ICustomFormField(
    formHint: '0',
    formLabel: '',
    formPrefixIcon: '',
    showSuffixIcon: false,
    keyboardType: TextInputType.number,
  ),
  otpInputVal4: ICustomFormField(
    formHint: '0',
    formLabel: '',
    formPrefixIcon: '',
    showSuffixIcon: false,
    keyboardType: TextInputType.number,
  ),
  search: ICustomFormField(
    formHint: 'Search',
    formLabel: '',
    formPrefixIcon: 'assets/icons/search.png',
    showSuffixIcon: false,
    keyboardType: TextInputType.text,
  ),
);
