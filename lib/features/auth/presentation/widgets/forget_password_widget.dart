import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/forget_password/forget_password_bloc.dart';
import '../bloc/verify_account/verify_account_bloc.dart';
import 'SizedBoxWidget.dart';


import '../../../../core/constants.dart';
import '../../../../core/widgets/toast_widget.dart';
import '../bloc/check_otp/check_otp_bloc.dart';
import '../bloc/send_otp/send_otp_bloc.dart';
import '../pages/forget_password/forget_password.dart';
import 'ElvatedButtonWdget.dart';
import 'TextFormFieldWidget.dart';
import 'otp_widget.dart';

class ForgetPasswordWidget extends StatefulWidget {

  ForgetPasswordWidget({super.key});

  @override
  State<ForgetPasswordWidget> createState() => _ForgetPasswordWidgetState();
}

class _ForgetPasswordWidgetState extends State<ForgetPasswordWidget> {
  TextEditingController emailController = TextEditingController();

  GlobalKey<FormState> formKeyEmail = GlobalKey<FormState>();

  String? code;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return LayoutBuilder(builder: (context, constraints) {
              final MediaQueryData mediaQuery = MediaQuery.of(context);
              final double screenHeight = mediaQuery.size.height;
              final double textScaleFactor = mediaQuery.textScaleFactor;
              return AlertDialog(
                title: const Text(Constants.hintTextEmail),
                content: SizedBox(
                  height: screenHeight * 0.3,
                  width: constraints.maxWidth * 0.4,
                  child: Column(
                    children: [
                      TextFormFieldWidget(
                        formKey: formKeyEmail,
                        controller: emailController,
                        hintText: Constants.hintTextEmail,
                        labelText: Constants.labelTextEmail,
                        nameField: 'email',
                        fontSizeHintText:
                            Constants.fontSizeHintText * textScaleFactor,
                        fontSizeLableText:
                            Constants.fontSizeLableText * textScaleFactor,
                      ),
                      SizebBoxWidget(screenHeight: screenHeight * 2),
                      BlocConsumer<SendOtpBloc, SendOtpState>(
                        listener: (context, state) {
                          if (state is SendOtpError) {
                            showToastWidgetError(state.message[0]!);
                          }
                          if (state is SendOtpSuccess) {
                            Navigator.pop(context);
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text(Constants.enterCode),
                                    content: SizedBox(
                                      height: screenHeight * 0.3,
                                      width: constraints.maxWidth * 0.4,
                                      child: BlocConsumer<CheckOtpBloc,
                                          CheckOtpState>(
                                        listener: (context, state) {
                                          if (state is CheckOtpSuccess) {

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ForgetPassword(
                                                  email: emailController.text,
                                                  code: code!,
                                                  token: state.token,
                                                ),
                                              ),
                                            );
                                          }
                                          if (state is CheckOtpError) {
                                            showToastWidgetError(state.message[0]!);
                                          }
                                        },
                                        builder: (context, state) {
                                          return Column(
                                            children: [
                                              SizedBox(height: screenHeight * 0.10),
                                              OTPWidget(
                                                email: emailController.text,
                                                  onVerifyAccount: ({String? email, required String code}) {
                                                    setState(() {
                                                      this.code = code;
                                                    });
                                                    BlocProvider.of<CheckOtpBloc>(context).add(
                                                      CheckOtpAuthEvent(email: emailController.text, code: code),
                                                    );
                                                  }
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: constraints.maxWidth * 0.16,top: screenHeight*0.02),
                                                child: TextButton(onPressed: (){
                                                  BlocProvider.of<SendOtpBloc>(
                                                    context,
                                                  ).add(SendOtpAuthEvent(
                                                    email: emailController.text,
                                                  ));
                                                }, child:  Text(
                                                  Constants.resendCode,
                                                  style: TextStyle(
                                                    color: Constants.secondaryColor,
                                                    fontSize:
                                                    Constants.fontSizeWordsInsideButtons *
                                                        textScaleFactor,
                                                  ),
                                                ),),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                });
                          }
                        },
                        builder: (context, state) {
                          return MyElevatedButton(
                            width: constraints.maxWidth * 0.3,
                            onPressed: () {
                              BlocProvider.of<SendOtpBloc>(
                                context,
                              ).add(SendOtpAuthEvent(
                                email: emailController.text,
                              ));
                            },
                            child:state is SendOtpLoading? const Center(child: CircularProgressIndicator(color:Colors.white ,),): Text(
                              Constants.sendCode,
                              style: TextStyle(
                                color: Constants.primaryColor,
                                fontSize: Constants.fontSizeWordsInsideButtons *
                                    textScaleFactor,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            });
          },
        );
      },
      child: const Text(
        Constants.forgetPassword,
        style: TextStyle(
          fontSize: Constants.fontSizeWordsInsideButtons,
          color: Constants.secondaryColor,
        ),
      ),
    );
  }
}
