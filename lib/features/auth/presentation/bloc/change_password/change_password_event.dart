part of 'change_password_bloc.dart';

@immutable
abstract class ChangePasswordEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangePasswordAuthEvent extends ChangePasswordEvent {
  final String oldPassword;
  final String newPassword;
  final String confirmNewPassword;

  ChangePasswordAuthEvent(
      {required this.oldPassword,
      required this.newPassword,
      required this.confirmNewPassword});

  @override
  List<Object> get props => [oldPassword, newPassword, confirmNewPassword];
}

class VisibilityOldPasswordChangePasswordEvent extends ChangePasswordEvent {

}
class VisibilityNewPasswordChangePasswordEvent extends ChangePasswordEvent {

}
class VisibilityConfirmNewPasswordChangePasswordEvent extends ChangePasswordEvent {

}

