part of 'send_otp_bloc.dart';

@immutable
abstract class SendOtpState extends Equatable{
  @override
  List<Object>get props=>[];
}

class SendOtpInitial extends SendOtpState {}
class SendOtpSuccess extends SendOtpState {}
class SendOtpLoading extends SendOtpState {}
class SendOtpError extends SendOtpState {
  final List<String?> message ;

  SendOtpError({required this.message});
  @override
  List<Object>get props=>[message];
}
