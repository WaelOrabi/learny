import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../login/login.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/widgets/toast_widget.dart';
import '../../bloc/forget_password/forget_password_bloc.dart';
import '../../widgets/ElvatedButtonWdget.dart';
import '../../widgets/TextFormFieldWidget.dart';


class ForgetPassword extends StatelessWidget {
  ForgetPassword(
      {Key? key, required this.email, required this.code, required this.token})
      : super(key: key);
  static const String routeName="/forget password";
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
  TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final String email;
  final String code;
  final String token;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordSuccess) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return  Login();
          }));
        }
        if (state is ForgetPasswordError) {
          state.message.length == 1
              ? showToastWidgetError(state.message[0]!)
              : state.message
              .map((e) => showToastWidgetError(e!))
              .toList();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
            builder: (context, state) {
              return SafeArea(
                child: Container(
                  height:double.infinity,
                  width: double.infinity,
                  color: Constants.primaryColor,
                  child: LayoutBuilder(
                    builder: (context,constraints){
                      final MediaQueryData mediaQuery = MediaQuery.of(context);
                      final double screenHeight = mediaQuery.size.height;
                      final double textScaleFactor = mediaQuery.textScaleFactor;
                      return Align(
                        child: Container(
                          constraints: BoxConstraints(
                            maxHeight:screenHeight ,
                            maxWidth:constraints.maxWidth*0.5 ,
                          ),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: screenHeight * Constants.distanceBetweenFormsAndRestComponents),
                                const  Text(
                                  Constants.forgetPassword,
                                  style: TextStyle(
                                    color: Constants.primaryColor,
                                    fontSize: Constants.sizeWordsPages,
                                    fontWeight: Constants.fontWeight,
                                  ),
                                ),
                                SizedBox(height: screenHeight * Constants.distanceBetweenFormsAndRestComponents),
                                TextFormFieldWidget(
                                  controller: newPasswordController,
                                  obscureText: BlocProvider.of<ForgetPasswordBloc>(context).obscureTextNewPassword,
                                  hintText: Constants.hintTextNewPassword,
                                  labelText:Constants.labelTextNewPassword,
                                  distanceFromTop: screenHeight * Constants.distanceFromTopBetweenTwoTextFormField,
                                  nameField: 'password',
                                  fontSizeHintText: Constants.fontSizeHintText * textScaleFactor,
                                  fontSizeLableText: Constants.fontSizeLableText  * textScaleFactor,
                                ),
                                TextFormFieldWidget(
                                  controller: confirmNewPasswordController,
                                  obscureText: BlocProvider.of<ForgetPasswordBloc>(context).obscureTextConfirmNewPassword,
                                  hintText: Constants.hintTextConfirmNewPassword,
                                  labelText: Constants.labelTextConfirmNewPassword,
                                  distanceFromTop: screenHeight * Constants.distanceFromTopBetweenTwoTextFormField,
                                  nameField: 'confirm password',
                                  fontSizeHintText:Constants.fontSizeHintText* textScaleFactor,
                                  fontSizeLableText:Constants.fontSizeLableText * textScaleFactor,
                                ),
                                SizedBox(height: screenHeight * Constants.distanceBetweenFormsAndRestComponents),
                                MyElevatedButton(
                                  width: constraints.maxWidth * 0.2,
                                  height: screenHeight *
                                      Constants.heightElevatedButton,
                                  onPressed: () {
                                    BlocProvider.of<ForgetPasswordBloc>(context)
                                        .add(ForgetPasswordAuthEvent(
                                        newPassword: newPasswordController.text,
                                        confirmNewPassword:
                                        confirmNewPasswordController.text,
                                        email: email,
                                        code: code,
                                        token: token));
                                  },
                                  child: state is ForgetPasswordLoading?const Center(child: CircularProgressIndicator(color:Colors.white ,),): const Text(
                                    Constants.resetPassword,
                                    style: TextStyle(
                                      color: Constants.primaryColor,
                                      fontSize:Constants.fontSizeWordsInsideButtons,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
