import 'package:flutter/material.dart';
import '../../../../home/presentation/pages/home_page.dart';

import '../../../../../core/theme/my_App_Theme.dart';
import 'rest-sign-up.dart';

import '../../../../../core/constants.dart';

import '../../widgets/HaveAnAccountOrNotWidget.dart';
import '../../widgets/SizedBoxWidget.dart';
import '../../widgets/TextFormFieldWidget.dart';

class SignUp extends StatefulWidget {
  static const String routeName = '/sing-up';

  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final MediaQueryData mediaQuery = MediaQuery.of(context);
            final double screenHeight = mediaQuery.size.height;
            final double textScaleFactor = mediaQuery.textScaleFactor;
            return Center(
              child: Container(
                color: MyAppTheme.myTheme.primaryColor,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: constraints.maxHeight * 0.03,
                  ),
                  child: SingleChildScrollView(
                    child: Form(

                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            Constants.signUp,
                            style: MyAppTheme.myTheme.textTheme.displayLarge,
                          ),
                          TextFormFieldWidget(
                            controller: firstNameController,
                            hintText: Constants.hintTextFirstName,
                            labelText: Constants.labelTextFirstName,
                            nameField: 'name',
                            distanceFromTop: screenHeight *
                                Constants
                                    .distanceFromTopBetweenTwoTextFormField,
                            fontSizeHintText:
                                Constants.fontSizeHintText * textScaleFactor,
                            fontSizeLableText:
                                Constants.fontSizeLableText * textScaleFactor,
                          ),
                          TextFormFieldWidget(
                            controller: lastNameController,
                            hintText: Constants.hintTextLastName,
                            labelText: Constants.labelTextLastName,
                            nameField: 'name',
                          ),
                          TextFormFieldWidget(
                            controller: emailController,
                            hintText: Constants.hintTextEmail,
                            labelText: Constants.labelTextEmail,
                            nameField: 'email',

                          ),
                          TextFormFieldWidget(
                            controller: phoneController,
                            hintText: Constants.labelTextPhoneNumber,
                            labelText: Constants.hintTextPhoneNumber,
                            nameField: 'phone',
                          ),
                          SizebBoxWidget(screenHeight: screenHeight),
                          Padding(
                            padding: EdgeInsets.only(
                                right: constraints.maxWidth * 0.65),
                            child: TextButton(
                                onPressed: () {
                                  if (formKey.currentState!
                                          .validate()

                                   ) {

                                    showCenterDialog(context);
                                  }
                                },
                                child: Text(
                                  Constants.next,
                                  style: MyAppTheme.myTheme.textTheme.titleMedium,
                                )),
                          ),
                          SizebBoxWidget(screenHeight: screenHeight * 2),
                          Padding(
                            padding: EdgeInsets.only(
                                right: constraints.maxWidth * 0.5),
                            child: HaveAnAccountOrNotWidget(
                                textHaveAnAccountOrNot:
                                    Constants.alreadyHaveAnAccount,
                                signUpOrLogIn: Constants.login,
                                screenWidth: constraints.maxWidth,
                                textScaleFactor: textScaleFactor),
                          ),
                          SizebBoxWidget(screenHeight: screenHeight * 2),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  void showCenterDialog(BuildContext context) {
    showDialog(
      context: context,

      builder: (BuildContext context) {
        return  Dialog(

          child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width * 0.8,
              child:RestSignUp(
                firstName: firstNameController.text,
                lastName: lastNameController.text,
                email: emailController.text,
                phoneNumber: phoneController.text,
              ),),


        );
      },
    );
  }
}
