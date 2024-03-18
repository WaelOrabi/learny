part of 'forget_password_bloc.dart';

@immutable
abstract class ForgetPasswordEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ForgetPasswordAuthEvent extends ForgetPasswordEvent {
  final String email;
  final String code;
  final String newPassword;
  final String confirmNewPassword;
  final String token;

  ForgetPasswordAuthEvent(
      {required this.email,
      required this.code,
      required this.newPassword,
      required this.confirmNewPassword,
      required this.token
      });
  @override
  List<Object> get props => [email,code,newPassword,confirmNewPassword,token];
}
class VisibilityConfirmPasswordForgetPasswordEvent extends ForgetPasswordEvent {

}

class VisibilityNewPasswordForgetPasswordEvent extends ForgetPasswordEvent {

}