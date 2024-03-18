part of 'check_otp_bloc.dart';

@immutable
abstract class CheckOtpEvent extends Equatable{
  @override
  List<Object>get props=>[];
}
class CheckOtpAuthEvent extends CheckOtpEvent{
 final String email;
 final String code;

  CheckOtpAuthEvent({required this.email,required this.code});
 @override
 List<Object>get props=>[email,code];
}
