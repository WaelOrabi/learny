part of 'logout_bloc.dart';

@immutable
abstract class LogoutEvent extends Equatable{
@override
List<Object> get props=>[];
}

class LogoutAuthEvent extends LogoutEvent{}