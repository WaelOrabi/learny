part of 'send_otp_bloc.dart';

@immutable
abstract class SendOtpEvent extends Equatable{
  @override
  List<Object>get props=>[];
}

class SendOtpAuthEvent extends SendOtpEvent{
  final String email;
  SendOtpAuthEvent({required this.email});
  @override
  List<Object>get props=>[email];
}
