part of 'forget_password_bloc.dart';

@immutable
abstract class ForgetPasswordState extends Equatable{
  @override
  List<Object>get props=>[];
}

class ForgetPasswordInitial extends ForgetPasswordState {}
class ForgetPasswordLoading extends ForgetPasswordState {}
class ForgetPasswordSuccess extends ForgetPasswordState {}
class ForgetPasswordError extends ForgetPasswordState {
 final List<String?>message;

  ForgetPasswordError({required this.message});
 @override
 List<Object>get props=>[message];

}
class NewPasswordForgetPasswordState extends ForgetPasswordState {
  final bool isNewPasswordVisible;

  NewPasswordForgetPasswordState({required this.isNewPasswordVisible});
}
class ConfirmNewPasswordForgetPasswordState extends ForgetPasswordState {
  final bool isConfirmNewPasswordVisible;

  ConfirmNewPasswordForgetPasswordState({required this.isConfirmNewPasswordVisible});
}