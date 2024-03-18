part of 'verify_account_bloc.dart';

@immutable
abstract class VerifyAccountEvent extends Equatable{
  @override
  List<Object>get props=>[];
}

class VerifyAccountAuthEvent extends VerifyAccountEvent{
  final String email;
  final String code;

  VerifyAccountAuthEvent({required this.email,required this.code});

}
