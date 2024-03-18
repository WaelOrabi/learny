import 'package:flutter/material.dart';
import '../../../../core/theme/my_App_Theme.dart';


// ignore: must_be_immutable
class TextFormFieldWidget extends StatefulWidget {
  TextFormFieldWidget(
      {super.key,
      required this.hintText,
      required this.labelText,
      this.distanceFromTop = 20,
      required this.controller,
      required this.nameField,
      this.fontSizeHintText = 24,
      this.fontSizeLableText = 12,
      this.function,
      this.obscureText = false,
      this.formKey});

  bool obscureText;

  final String hintText;
  final String nameField;
  final double fontSizeHintText;
  final double fontSizeLableText;
  final double distanceFromTop;
  final String labelText;
  final Function()? function;
  final TextEditingController controller;
  final GlobalKey<FormState>? formKey;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: widget.distanceFromTop, left: 70, right: 70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.labelText,
            style: MyAppTheme.myTheme.textTheme.labelMedium,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(

            style: MyAppTheme.myTheme.textTheme.bodyMedium,
            validator: widget.nameField == 'name'
                ? validateName
                : widget.nameField == 'email'
                    ? validateEmail
                    : widget.nameField == 'phone'
                        ? validateMobile
                        :(widget.nameField=='password'||widget.nameField=='confirm password')? validatePassword:widget.nameField=='date birth'?validateDate:null,
            controller: widget.controller,
            obscureText: widget.nameField == 'password' ||
                    widget.nameField == 'confirm password'
                ? widget.obscureText
                : false,
            keyboardType: widget.nameField == 'name'
                ? TextInputType.name
                : widget.nameField == 'email'
                    ? TextInputType.emailAddress
                    : widget.nameField == 'phone'
                        ? TextInputType.phone
                        : TextInputType.visiblePassword,
            onSaved: (value) {
              widget.controller.text = value!;
            },
            decoration: InputDecoration(
              errorText: errorText,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              suffixIcon: widget.nameField == 'name'
                  ? Icon(
                      Icons.person,
                      size: MyAppTheme.myTheme.primaryIconTheme.size,
                      color: MyAppTheme.myTheme.primaryIconTheme.color,
                    )
                  : widget.nameField == 'email'
                      ? Icon(
                          Icons.email_outlined,
                          size: MyAppTheme.myTheme.primaryIconTheme.size,
                          color: MyAppTheme.myTheme.primaryIconTheme.color,
                        )
                      : widget.nameField == 'phone'
                          ? Icon(
                              Icons.phone,
                              size: MyAppTheme.myTheme.primaryIconTheme.size,
                              color:
                                  MyAppTheme.myTheme.primaryIconTheme.color,
                            )
                          : (widget.nameField == 'password' ||
                                  widget.nameField == 'confirm password')
                              ? IconButton(
                                  icon: widget.obscureText
                                      ? Icon(
                                          Icons.visibility,
                                          size: MyAppTheme
                                              .myTheme.primaryIconTheme.size,
                                          color: MyAppTheme
                                              .myTheme.primaryIconTheme.color,
                                        )
                                      : Icon(
                                          Icons.visibility_off,
                                          size: MyAppTheme
                                              .myTheme.primaryIconTheme.size,
                                          color: MyAppTheme
                                              .myTheme.primaryIconTheme.color,
                                        ),
                                  onPressed: widget.function,
                                )
                              : IconButton(
                                  onPressed: widget.function,
                                  icon: Icon(
                                    Icons.calendar_today,
                                    size: MyAppTheme
                                        .myTheme.primaryIconTheme.size,
                                    color: MyAppTheme
                                        .myTheme.primaryIconTheme.color,
                                  ),
                                ),
              hintMaxLines: 1,
              hintText: widget.hintText,
              hintStyle: MyAppTheme.myTheme.inputDecorationTheme.hintStyle,
              border: MyAppTheme.myTheme.inputDecorationTheme.border,
              enabledBorder:
                  MyAppTheme.myTheme.inputDecorationTheme.enabledBorder,
              focusedBorder:
                  MyAppTheme.myTheme.inputDecorationTheme.focusedBorder,
            ),
          ),
        ],
      ),
    );
  }
}

String? validateEmail(String? value) {
  const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
  final regex = RegExp(pattern);
  if (value!.isEmpty) {
    return 'Please enter mobile number';
  }
  return value.isNotEmpty && !regex.hasMatch(value)
      ? 'Enter a valid email address'
      : null;
}

String? validateMobile(String? value) {
  String pattern = r'^[+]?[0-9]{10,12}$';

  RegExp regExp = RegExp(pattern);
  if (value!.isEmpty) {
    return 'Please enter mobile number';
  } else if (!regExp.hasMatch(value)) {
    return 'Please enter valid mobile number';
  }
  return null;
}

String? validateName(String? value) {
  RegExp regex = RegExp(r'^[a-zA-Z ]+$');

  if (value!.isEmpty) {
    return 'Please enter name';
  } else if (!regex.hasMatch(value)) {
    return 'Please enter valid name';
  }
  return null;
}

String? validatePassword(String? value) {
  // Define the regex pattern for password validation
  RegExp passwordRegex = RegExp(
    r'^.{4,}$',
  );
  if (value!.isEmpty) {
    return 'Please enter password';
  }
  else if(value.length < 4) {
    return 'Password must be at least four characters long';
  }
  else if (!passwordRegex.hasMatch(value)) {
    return 'Please re-enter the password';
  }

  return null;
}
String? validateDate(String? value) {
  final RegExp dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$'); // format: YYYY-MM-DD

if(value!.isEmpty)
  {
    return 'Please enter date';
  }
else if(!dateRegex.hasMatch(value))
  {
    return 'Please re-enter the date ';
  }
}
