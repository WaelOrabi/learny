import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learny_project/features/auth/data/models/user_model.dart';
import 'package:learny_project/features/auth/presentation/pages/verify_account/verify_account.dart';
import 'package:learny_project/features/home/presentation/pages/home_page.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/theme/my_App_Theme.dart';
import '../../../../../core/widgets/toast_widget.dart';
import '../../bloc/sign_up/sign_up_bloc.dart';
import '../../widgets/drop_down_form_gender_widget.dart';
import '../../widgets/ElvatedButtonWdget.dart';
import '../../widgets/HaveAnAccountOrNotWidget.dart';
import '../../widgets/SizedBoxWidget.dart';
import '../../widgets/TextFormFieldWidget.dart';

class RestSignUp extends StatefulWidget {
  static const String routeName = '/rest-sign-up';
  final String firstName, lastName, phoneNumber, email;

  const RestSignUp(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.email})
      : super(key: key);

  @override
  State<RestSignUp> createState() => _RestSignUpState();
}

class _RestSignUpState extends State<RestSignUp> {
  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;

  bool obscureTextPassword = true;
  bool obscureTextConfirmPassword = true;
  final TextEditingController _dateController = TextEditingController();



  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(

      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            // Change the colors and styles of the date picker here
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              surface: Colors.blue,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
   
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = picked.toString().split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  SafeArea _buildBody() {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final MediaQueryData mediaQuery = MediaQuery.of(context);
          final double screenHeight = mediaQuery.size.height;
          final double textScaleFactor = mediaQuery.textScaleFactor;
          return Center(
                child: Container(
                  color: MyAppTheme.myTheme.primaryColor,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10, left: constraints.maxWidth * 0.045),
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.arrow_back_ios_new_outlined,
                                size: MyAppTheme.myTheme.primaryIconTheme.size,
                                color:
                                    MyAppTheme.myTheme.primaryIconTheme.color,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 70, top: 10, right: 70, bottom: 0),
                          child: Form(
                            key: formKey,

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Constants.labelTextGender,
                                  style:
                                      MyAppTheme.myTheme.textTheme.labelMedium,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 100,
                                ),
                                if (Constants.genderItems.isNotEmpty)
                                  BlocBuilder<SignUpBloc, SignUpState>(
                                    builder: (context, state) {
                                      return FormGender(
                                        hintText: Constants.hintTextGender,
                                        value:
                                            BlocProvider.of<SignUpBloc>(context)
                                                .dropDownValue,
                                        items: Constants.genderItems,
                                        onChanged: (value) {
                                          BlocProvider.of<SignUpBloc>(context)
                                              .add(DropDownValueEvent(
                                                  dropDownValue: value));
                                          setState(() {

                                          });
                                        },
                                      );
                                    },
                                  ),
                              ],
                            ),
                          ),
                        ),
                        TextFormFieldWidget(
                          hintText: Constants.hintTextDateBirth,
                          labelText: Constants.labelTextDateBirth,
                          controller: _dateController,
                          nameField: 'date birth',
                          function: () => _selectDate(context),
                        ),
                        BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {

                            if (state is VisibilitySignUpState) {
                              obscureTextPassword = state.isPasswordVisible;
                              obscureTextConfirmPassword=state.isConfirmPasswordVisible;
                            }
                            return Column(
                              children: [
                                TextFormFieldWidget(
                                  controller: passwordController,
                                  hintText: Constants.hintTextPassword,
                                  labelText: Constants.labelTextPassword,
                                  nameField: 'password',
                                  obscureText: obscureTextPassword,
                                  function: () {
                                    BlocProvider.of<SignUpBloc>(context)
                                        .add(VisibilityPasswordSignUpEvent());
                                  },
                                ),
                                TextFormFieldWidget(
                                  controller: confirmPasswordController,
                                  hintText: Constants.hintTextPassword,
                                  labelText: Constants.labelTextConfirmPassword,
                                  nameField: 'confirm password',
                                  obscureText: obscureTextConfirmPassword,
                                  function: () {
                                    BlocProvider.of<SignUpBloc>(context).add(
                                        VisibilityConfirmPasswordSignUpEvent());
                                  },
                                )
                              ],
                            );
                          },
                        ),

                        SizebBoxWidget(screenHeight: screenHeight * 2),
                        Padding(
                          padding: EdgeInsets.only(
                              left: constraints.maxWidth * 0.05),
                          child: HaveAnAccountOrNotWidget(
                              textHaveAnAccountOrNot:
                                  Constants.alreadyHaveAnAccount,
                              signUpOrLogIn: Constants.login,
                              screenWidth: constraints.maxWidth,
                              textScaleFactor: textScaleFactor),
                        ),
                        SizebBoxWidget(screenHeight: screenHeight),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BlocConsumer<SignUpBloc, SignUpState>(
                              listener: (context, state) async{
                                if (state is SignUpError) {
                                  for(int i=0;i<state.message.length;i++)
                                  {
                                    if (state.message[i] == 'Invalid data') {
                                      showToastWidgetError('password is incorrect') ;
                                      continue;
                                    }
                                    showToastWidgetError(state.message[i]!);
                                    await Future.delayed(const Duration(seconds: 4));
                                  }
                                } else if (state is SignUpSuccess) {
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context){
                                    return  VerifyAccount(email: widget.email);
                                  }));
                                }
                              },
                              builder:(context,state)=> MyElevatedButton(
                                width: constraints.maxWidth * 0.2,
                                height: screenHeight *
                                    Constants.heightElevatedButton,
                                onPressed: () {
                                  BlocProvider.of<SignUpBloc>(context).add(
                                    SignUpAuthEvent(
                                      user: UserModel(
                                        firstName: widget.firstName,
                                        lastName: widget.lastName,
                                        birthDate: _dateController.text,
                                        email: widget.email,
                                        gender: BlocProvider.of<SignUpBloc>(
                                            context)
                                            .dropDownValue!,
                                        password: passwordController.text,
                                        confirmPassword:
                                        confirmPasswordController.text,
                                        phoneNumber: widget.phoneNumber,
                                        nationalityId: "1",
                                      ),
                                    ),
                                  );
                                },
                                child: state is SignUpLoading?const Center(child: CircularProgressIndicator(color:Colors.white ,),): Text(
                                  Constants.signUp,
                                  style: MyAppTheme
                                      .myTheme.textTheme.headlineMedium,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
        },
      ),
    );
  }
}
