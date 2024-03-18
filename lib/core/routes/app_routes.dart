
import 'package:flutter/material.dart';
import '../../features/auth/presentation/pages/change_password/change_password.dart';
import '../../features/auth/presentation/pages/forget_password/forget_password.dart';
import '../../features/auth/presentation/pages/signup/sign-up.dart';
import '../../features/content/presentation/pages/paragraphs/paragraphs.dart';
import '../../features/content/presentation/pages/questions/questions.dart';
import '../../features/teachers/presentation/pages/become_a_teacher.dart';
import '../../features/auth/presentation/pages/login/login.dart';
import '../../features/auth/presentation/pages/signup/rest-sign-up.dart';
import '../../features/auth/presentation/pages/verify_account/verify_account.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/teachers/presentation/pages/request_details.dart';
import '../../features/teachers/presentation/pages/teacher_requests.dart';
import '../../features/working_times/presentation/pages/working_times.dart';



class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
     "/questions":(context)=>Questions(),
     "/paragraphs":(context)=>Paragraphs(),
    Login.routeName: (context) => Login(),
    ChangePassword.routeName: (context) => ChangePassword(),
    ForgetPassword.routeName: (context) => ForgetPassword(email: "", code: "", token: ""),
    SignUp.routeName: (context) => const SignUp(),
    RestSignUp.routeName: (context) =>const RestSignUp(firstName: '', lastName: '', phoneNumber: '', email: '',),
    VerifyAccount.routeName: (context) => VerifyAccount(email: '',),
  };
}
