import 'dart:ui';

import 'package:flutter/material.dart';

class Constants{
  Constants._();


 // Colors
static const primaryColor= Color(0xFFFFFFFF);
static const secondaryColor=Color(0xff30c7ec);
static const blackColor=Colors.black;
static const cyanColoraec6cf=Color(0xffaec6cf);
static const cyanColorCombination=[
  Color(0xff16D9E3),
  Color(0xff30C7EC),
  Color(0xff46AEF7),
];
 // Strings
static const String enterCode='Enter the code' ;
static const String sendCode='Send code';
static const String changePassword='Change Password';
static const String hintTextCurrentPassword='Enter current password';
static const String labelTextCurrentPassword= 'current password';
static const String hintTextNewPassword='Enter new password';
static const String labelTextNewPassword='new password';
static const String hintTextConfirmNewPassword='Enter confirm new password';
static const String labelTextConfirmNewPassword= 'confirm new password';
static const String resetPassword='Reset Password';
static const String forgetPassword='Forget Password';
static const String login='Login';
static const String signUp= 'Sign Up';
static const String next='next >>';
static const String hintTextEmail='Enter your email';
static const String labelTextEmail='Email';
static const String hintTextPassword='Enter your password';
static const String labelTextPassword='Password';
static const String continueWithGoogle= 'Continue with Google';
static const String dontHaveAnAccount= 'Don\'t have an account?  ';
static const String alreadyHaveAnAccount=  'Already have an account?  ';
static const String hintTextConfirmPassword='Enter your confirm password';
static const String labelTextConfirmPassword='Confirm Password';
static const String   verifyAccount='Verify Account';
static const String hintTextFirstName='Enter your first name';
static const String labelTextFirstName='First name';
static const String hintTextLastName='Enter your last name';
static const String labelTextLastName='Last name';
static const String hintTextPhoneNumber='Enter your phone number';
static const String labelTextPhoneNumber='Phone number';
static const String submit='Submit';
static const List<String> genderItems = ['male', 'female'];
 static final List<String> weekDays = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

static const String hintTextGender='Select Your Gender';
static const String labelTextGender='gender';
static const String hintTextDateBirth= 'Date of Birth';
static const String labelTextDateBirth='Date of Birth';
static const String resendCode='resend code';
// Fonts
static const double fontSizeHintText=12.0;
static const double fontSizeLableText=12.0;
static const double fontSizeWordsInsideButtons=16.0;
static const double sizeWordsPages=32.0;
static const FontWeight fontWeight=FontWeight.bold;
static const double fontSizeCharactersInTextFormField=20;

// Distance between components
static const double distanceFromTopBetweenTwoTextFormField=0.02;
static const double distanceBetweenFormsAndRestComponents=0.05;

// Height And Width For Components
static const double heightElevatedButton=0.08;

}