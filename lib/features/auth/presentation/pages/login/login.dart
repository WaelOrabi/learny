import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learny_project/features/auth/data/models/user_model.dart';
import '../../../../../core/error/exception.dart';
import '../../../../home/presentation/pages/home_page_admin.dart';
import '../../../data/datasources/local_data_sources/auth_local_data_sources.dart';
import '../../bloc/login/login_bloc.dart';
import '../../widgets/ElvatedButtonWdget.dart';
import '../../../../home/presentation/pages/home_page.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/theme/my_App_Theme.dart';
import '../../../../../core/widgets/toast_widget.dart';
import '../../widgets/HaveAnAccountOrNotWidget.dart';
import '../../widgets/SizedBoxWidget.dart';
import '../../widgets/TextFormFieldWidget.dart';
import '../../widgets/forget_password_widget.dart';
import 'package:learny_project/injection_container.dart' as di;
class Login extends StatelessWidget {
  static const String routeName = '/login';
  final TextEditingController emailController1 = TextEditingController();
  final TextEditingController emailController2 = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthLocalDataSources _authLocalDataSourcesImpl =
  di.sl<AuthLocalDataSources>();
  String? token;
  Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          final MediaQueryData mediaQuery = MediaQuery.of(context);
          final double screenHeight = mediaQuery.size.height;
          final double textScaleFactor = mediaQuery.textScaleFactor;
          return
              Center(
                child: Container(
                  color: Constants.primaryColor,
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
                              Constants.login,
                              style:MyAppTheme.myTheme.textTheme.displayLarge,
                            ),
                            TextFormFieldWidget(
                              controller: emailController1,
                              hintText: Constants.hintTextEmail,
                              labelText: Constants.labelTextEmail,
                              distanceFromTop: screenHeight *
                                  Constants
                                      .distanceFromTopBetweenTwoTextFormField,
                              nameField: 'email',
                              fontSizeHintText:
                              Constants.fontSizeHintText * textScaleFactor,
                              fontSizeLableText:
                              Constants.fontSizeLableText * textScaleFactor,
                            ),
                            BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                                bool obscureText = true;
                                if (state is PasswordLoginState) {
                                  obscureText = state.isPasswordVisible;
                                }
                                return TextFormFieldWidget(
                                  controller: passwordController,
                                  hintText: Constants.hintTextPassword,
                                  labelText: Constants.labelTextPassword,
                                  distanceFromTop: screenHeight *
                                      Constants
                                          .distanceFromTopBetweenTwoTextFormField,
                                  nameField: 'password',
                                  fontSizeHintText: Constants.fontSizeHintText *
                                      textScaleFactor,
                                  fontSizeLableText:
                                  Constants.fontSizeLableText *
                                      textScaleFactor,
                                  obscureText: obscureText,
                                  function: () {
                                    BlocProvider.of<LoginBloc>(context)
                                        .add(ToggleVisibilityLoginEvent());
                                  },
                                );
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: constraints.maxWidth * 0.72,
                                  top: screenHeight * 0.02),
                              child: ForgetPasswordWidget(),
                            ),
                            SizebBoxWidget(screenHeight: screenHeight * 1),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: constraints.maxWidth * 0.65),
                              child: HaveAnAccountOrNotWidget(
                                textHaveAnAccountOrNot:
                                Constants.dontHaveAnAccount,
                                signUpOrLogIn: Constants.signUp,
                                screenWidth: constraints.maxWidth,
                                textScaleFactor: textScaleFactor,
                              ),
                            ),
                            SizebBoxWidget(screenHeight: screenHeight * 4),
                            BlocConsumer<LoginBloc, LoginState>(
                              listener: (context, state) async{
                                if (state is LoginSuccess) {
                                  UserModel? userModel=await _loadUser();
                                  Widget screen=Container();
                                  bool isAdmin=false;
                                 if(userModel!=null){
                                   userModel.roles!.map((e){
                                     if(e.name=="owner" || e.name=="admin"){
                                       isAdmin=true;
                                     }
                                   }).toList();
                                 }
                                  if(isAdmin){
                                    screen=HomePageAdmin();
                                  }else{
                                    screen=HomePage(userModel: userModel,);
                                  }

                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (context) {
                                        return screen;
                                      }));
                                } else if (state is LoginError) {

                                  for(int i=0;i<state.message.length;i++)
                                    {
                                      if (state.message[i] == 'Invalid data') {
                                        showToastWidgetError('password is incorrect') ;
                                        continue;
                                      }
                                      showToastWidgetError(state.message[i]!);
                                      await Future.delayed(const Duration(seconds: 4));
                                    }
                                }
                              },
                              builder:  (context, state) {
                                  return MyElevatedButton(
                                    width: constraints.maxWidth * 0.2,
                                    height: screenHeight *
                                        Constants.heightElevatedButton,
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        BlocProvider.of<LoginBloc>(context).add(
                                          LoginAuthEvent(
                                            email: emailController1.text,
                                            password: passwordController.text,
                                          ),
                                        );
                                      }
                                    },
                                    child: state is LoginLoading?const Center(child: CircularProgressIndicator(color:Colors.white ,),):Text(
                                      Constants.login,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                        Constants.fontSizeWordsInsideButtons *
                                            textScaleFactor,
                                      ),
                                    ),
                                  );
                                },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );

        }),
      ),
    );
  }
  Future<UserModel?> _loadUser() async {
    try {
      final value = await _authLocalDataSourcesImpl.getCachedUser();
      return value;

    } catch (error) {
      if (error is EmptyCacheException) {
       return null;
      }
    }
  }
}
