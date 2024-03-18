part of 'logout_bloc.dart';

@immutable
abstract class LogoutState extends Equatable{
  const LogoutState();
  @override
  List<Object> get props=>[];
}

class LogoutInitial extends LogoutState {}
class LogoutLoading extends LogoutState {}
class LogoutSuccess extends LogoutState {}
class LogoutError extends LogoutState {
  final List<String?> message;
  LogoutError({required this.message});

  @override
  List<Object>get props=>[message];
}
