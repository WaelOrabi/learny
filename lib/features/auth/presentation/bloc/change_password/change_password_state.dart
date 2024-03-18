part of 'change_password_bloc.dart';

@immutable
abstract class ChangePasswordState extends Equatable{
  @override
  List<Object>get props=>[];
}

class ChangePasswordInitial extends ChangePasswordState {}
class ChangePasswordLoading extends ChangePasswordState {}
class ChangePasswordSuccess extends ChangePasswordState {

  @override
  List<Object>get props=>[];
}
class ChangePasswordError extends ChangePasswordState {
  final List<String?> message;
  ChangePasswordError({required this.message});

  @override
  List<Object>get props=>[message];

}
class VisibilityOldPasswordChangePasswordState extends ChangePasswordState {
final bool obscureText;

  VisibilityOldPasswordChangePasswordState({required this.obscureText});
}
class VisibilityNewPasswordChangePasswordState extends ChangePasswordState {
final bool obscureText;

  VisibilityNewPasswordChangePasswordState({required this.obscureText});

}
class VisibilityConfirmNewPasswordChangePasswordState extends ChangePasswordState {
final bool obscureText;

  VisibilityConfirmNewPasswordChangePasswordState({required this.obscureText});

}
