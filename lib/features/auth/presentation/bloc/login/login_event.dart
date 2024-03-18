part of 'login_bloc.dart';

@immutable
abstract class LoginEvent  extends Equatable{
  @override
  List<Object> get props=>[];
}

class LoginAuthEvent extends LoginEvent{
  final String email;
  final String password;

  LoginAuthEvent({required this.email,required this.password});
}
class ToggleVisibilityLoginEvent extends LoginEvent {}
