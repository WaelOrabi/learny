import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learny_project/features/auth/presentation/widgets/otp_widget.dart';
import '../../../../../core/error/exception.dart';
import '../../../../home/presentation/pages/home_page_admin.dart';
import '../../../data/datasources/local_data_sources/auth_local_data_sources.dart';
import '../../../data/models/user_model.dart';
import '../../bloc/verify_account/verify_account_bloc.dart';
import '../../../../home/presentation/pages/home_page.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/widgets/toast_widget.dart';
import 'package:learny_project/injection_container.dart' as di;
class VerifyAccount extends StatelessWidget {
  static const String routeName = "/verify-account";
  final AuthLocalDataSources _authLocalDataSourcesImpl =
  di.sl<AuthLocalDataSources>();
  String? token;
  final String email;
  List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  VerifyAccount({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerifyAccountBloc, VerifyAccountState>(
      listener: (context, state)async {
        if (state is VerifyAccountSuccess) {
          UserModel? _userModel=await _loadUser();
          Widget _screen=Container();
          bool _isAdmin=false;
         if(_userModel!= null){
           _userModel.roles!.map((e){
             if(e.name=="owner" || e.name=="admin"){
               _isAdmin=true;
             }
           }).toList();
         }
          if(_isAdmin){
            _screen=HomePageAdmin();
          }else{
            _screen=HomePage(userModel: _userModel,);
          }
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => _screen));
        } else if (state is VerifyAccountError) {
          String error;
          error = state.message[0]!;
          if (error == 'Invalid data') {
            error = 'The entered code is incorrect';
          }
          state.message.length == 1
              ? showToastWidgetError(error)
              : state.message.map((e) => showToastWidgetError(e!)).toList();
        }
      },
      builder: (context, state) {
        final MediaQueryData mediaQuery = MediaQuery.of(context);
        final double screenHeight = mediaQuery.size.height;
        final double textScaleFactor = mediaQuery.textScaleFactor;
        return Scaffold(
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Container(
                      color: Colors.grey.shade100,
                    ),
                    Center(
                      child: Container(
                        height: constraints.maxHeight * 0.5,
                        width: constraints.maxWidth * 0.5,
                        color: Constants.primaryColor,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Align(
                              child: Container(
                                color: Constants.primaryColor,
                                constraints: BoxConstraints(
                                  maxWidth: constraints.maxWidth * 0.5,
                                  maxHeight: screenHeight * 0.5,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        height: screenHeight *
                                            Constants
                                                .distanceBetweenFormsAndRestComponents),
                                    Text(
                                      Constants.verifyAccount,
                                      style: TextStyle(
                                        color: Constants.secondaryColor,
                                        fontSize: Constants.sizeWordsPages *
                                            textScaleFactor,
                                        fontWeight: Constants.fontWeight,
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.10),
                                    OTPWidget(
                                      email: email,
                                      onVerifyAccount: ({String? email,required String code}) {
                                        BlocProvider.of<VerifyAccountBloc>(context).add(
                                          VerifyAccountAuthEvent(email: email!, code: code),
                                        );
                                      },
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        Constants.resendCode,
                                        style: TextStyle(
                                          color: Constants.cyanColoraec6cf,
                                          fontSize: Constants
                                                  .fontSizeWordsInsideButtons *
                                              textScaleFactor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
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
