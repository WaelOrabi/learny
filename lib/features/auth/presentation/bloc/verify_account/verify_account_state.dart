part of 'verify_account_bloc.dart';

@immutable
abstract class VerifyAccountState extends Equatable {

  @override
  List<Object>get props=>[];
}

class VerifyAccountInitial extends VerifyAccountState {}
class VerifyAccountSuccess extends VerifyAccountState {
 final UserEntity user;
  VerifyAccountSuccess({required this.user});
 @override
 List<Object>get props=>[user];
}
class VerifyAccountError extends VerifyAccountState {
  List<String?> message;
  VerifyAccountError({required this.message});
  @override
  List<Object>get props=>[message];
}
class VerifyAccountLoading  extends VerifyAccountState {}
