part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpState extends Equatable{
  @override
  List<Object>get props=>[];
}

class SignUpInitial extends SignUpState {}
class SignUpLoading extends SignUpState {}
class SignUpSuccess extends SignUpState {}
class SignUpError extends SignUpState {
  final List<String?> message;
  SignUpError({required this.message});

  @override
  List<Object>get props=>[message];

}
class DropDownValueState extends SignUpState{
  final String? dropDownValue;

  DropDownValueState({required this.dropDownValue});
}
class VisibilitySignUpState extends SignUpState {
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;

  VisibilitySignUpState({required this.isPasswordVisible, required this.isConfirmPasswordVisible});
  @override
  List<Object> get props => [isPasswordVisible, isConfirmPasswordVisible];
}

