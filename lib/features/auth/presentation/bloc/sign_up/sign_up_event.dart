part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent extends Equatable {
  @override
  List<Object>get props=>[];
}

class SignUpAuthEvent extends SignUpEvent{
  final UserModel user;

  SignUpAuthEvent({required this.user});

  @override
  List<Object>get props=>[user];

}
class DropDownValueEvent extends SignUpEvent{
  final String? dropDownValue;

  DropDownValueEvent({required this.dropDownValue});
}
class VisibilityConfirmPasswordSignUpEvent extends SignUpEvent {
  @override
  List<Object> get props => [];
}

class VisibilityPasswordSignUpEvent extends SignUpEvent {
  @override
  List<Object> get props => [];
}