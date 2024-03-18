part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable{
  const LoginState();
  @override
  List<Object> get props=>[];
}

class LoginInitial extends LoginState {}
class LoginLoading extends LoginState{}
class LoginSuccess extends LoginState{
  final UserEntity user;

  const LoginSuccess({required this.user});

  @override
  List<Object>get props=>[user];
}
class LoginError extends LoginState{
  final List<String?> message;

  const LoginError({required this.message});
  @override
  List<Object>get props=>[message];
}
class PasswordLoginState extends LoginState {
  final bool isPasswordVisible;

  const PasswordLoginState({required this.isPasswordVisible});
  @override
  List<Object> get props => [isPasswordVisible];
}
