import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/widgets/toast_widget.dart';
import '../../bloc/change_password/change_password_bloc.dart';
import '../../widgets/ElvatedButtonWdget.dart';
import '../../widgets/TextFormFieldWidget.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({Key? key}) : super(key: key);
  static const String routeName = "/change password";
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
          builder: (context, state) {
            if(state is ChangePasswordSuccess) {
              showToastWidgetSuccess('password changed successfully');
            } else if (state is ChangePasswordError) {
              state.message.length == 1
                  ? showToastWidgetError(state.message[0]!)
                  : state.message.map((e) => showToastWidgetError(e!)).toList();
            }
            return Container(
              height: double.infinity,
              width: double.infinity,
              color: Constants.primaryColor,
              child: LayoutBuilder(builder: (context, constraints) {
                final MediaQueryData mediaQuery = MediaQuery.of(context);
                final double screenHeight = mediaQuery.size.height;
                final double textScaleFactor = mediaQuery.textScaleFactor;
                return Align(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: screenHeight,
                      maxHeight: constraints.maxWidth * 0.5,
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: screenHeight *
                                  Constants
                                      .distanceBetweenFormsAndRestComponents),
                          Text(
                            Constants.changePassword,
                            style: TextStyle(
                              color: Constants.secondaryColor,
                              fontSize:
                                  Constants.sizeWordsPages * textScaleFactor,
                              fontWeight: Constants.fontWeight,
                            ),
                          ),
                          SizedBox(
                              height: screenHeight *
                                  Constants
                                      .distanceBetweenFormsAndRestComponents),
                          TextFormFieldWidget(
                            obscureText:
                                BlocProvider.of<ChangePasswordBloc>(context)
                                    .obscureTextOldPassword,
                            controller: currentPasswordController,
                            hintText: Constants.hintTextCurrentPassword,
                            labelText: Constants.labelTextCurrentPassword,
                            distanceFromTop: screenHeight *
                                Constants
                                    .distanceFromTopBetweenTwoTextFormField,
                            nameField: 'password',
                            fontSizeHintText:
                                Constants.fontSizeHintText * textScaleFactor,
                            fontSizeLableText:
                                Constants.fontSizeLableText * textScaleFactor,
                          ),
                          TextFormFieldWidget(
                            obscureText:
                                BlocProvider.of<ChangePasswordBloc>(context)
                                    .obscureTextNewPassword,
                            controller: newPasswordController,
                            hintText: Constants.hintTextNewPassword,
                            labelText: Constants.labelTextNewPassword,
                            distanceFromTop: screenHeight *
                                Constants
                                    .distanceFromTopBetweenTwoTextFormField,
                            nameField: 'password',
                            fontSizeHintText:
                                Constants.fontSizeHintText * textScaleFactor,
                            fontSizeLableText:
                                Constants.fontSizeLableText * textScaleFactor,
                          ),
                          TextFormFieldWidget(
                            obscureText:
                                BlocProvider.of<ChangePasswordBloc>(context)
                                    .obscureTextConfirmNewPassword,
                            controller: confirmNewPasswordController,
                            hintText: Constants.hintTextConfirmNewPassword,
                            labelText: Constants.labelTextConfirmNewPassword,
                            distanceFromTop: screenHeight *
                                Constants
                                    .distanceFromTopBetweenTwoTextFormField,
                            nameField: 'confirm password',
                            fontSizeHintText:
                                Constants.fontSizeHintText * textScaleFactor,
                            fontSizeLableText:
                                Constants.fontSizeLableText * textScaleFactor,
                          ),
                          SizedBox(
                              height: screenHeight *
                                  Constants
                                      .distanceBetweenFormsAndRestComponents),
                          MyElevatedButton(
                            width: constraints.maxWidth * 0.2,
                            height:
                                screenHeight * Constants.heightElevatedButton,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<ChangePasswordBloc>(context)
                                    .add(ChangePasswordAuthEvent(
                                        oldPassword:
                                            currentPasswordController.text,
                                        newPassword: newPasswordController.text,
                                        confirmNewPassword:
                                            confirmNewPasswordController.text));
                              }
                            },
                            child:state is ChangePasswordLoading?const Center(child: CircularProgressIndicator(color:Colors.white ,),): const Text(
                              Constants.resetPassword,
                              style: TextStyle(
                                color: Constants.primaryColor,
                                fontSize: Constants.fontSizeWordsInsideButtons,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
