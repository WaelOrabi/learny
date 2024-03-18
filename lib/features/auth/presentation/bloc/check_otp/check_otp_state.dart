part of 'check_otp_bloc.dart';

@immutable
abstract class CheckOtpState extends Equatable {
  @override
  List<Object>get props=>[];
}

class CheckOtpInitial extends CheckOtpState {}
class CheckOtpLoading extends CheckOtpState {}
class CheckOtpSuccess extends CheckOtpState {
  final String token;

  CheckOtpSuccess({required this.token});
  @override
  List<Object>get props=>[token];
}
class CheckOtpError extends CheckOtpState {
  final List<String?> message;
  CheckOtpError({required this.message});
  @override
  List<Object>get props=>[message];
}
