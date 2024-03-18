import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants.dart';
import '../../../../core/theme/my_App_Theme.dart';
import '../pages/login/login.dart';
import '../pages/signup/sign-up.dart';

class HaveAnAccountOrNotWidget extends StatelessWidget {
  const HaveAnAccountOrNotWidget({
    super.key,
    required this.screenWidth,
    required this.textScaleFactor,
    required this.textHaveAnAccountOrNot,
    required this.signUpOrLogIn,
  });

  final double screenWidth;
  final double textScaleFactor;
  final String textHaveAnAccountOrNot;
  final String signUpOrLogIn;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: MyAppTheme.myTheme.textTheme.displaySmall,
        children: [
          TextSpan(
            text: textHaveAnAccountOrNot,
          ),
          TextSpan(
            text: signUpOrLogIn,
            style:MyAppTheme.myTheme.textTheme.titleSmall,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
              Navigator.of(context).pop();
              showDialog(
                context: context,

                builder: (BuildContext context) {
                  return  Dialog(

                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.9,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child:signUpOrLogIn == 'Sign Up' ? const SignUp() : Login()),


                  );
                },
              );

              },
          ),
        ],
      ),
    );
  }
}
