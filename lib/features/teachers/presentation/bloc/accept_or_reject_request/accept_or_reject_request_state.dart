part of 'accept_or_reject_request_bloc.dart';

@immutable
abstract class AcceptOrRejectRequestState {}

class AcceptOrRejectRequestInitial extends AcceptOrRejectRequestState {}
class AcceptRequestLoadingState extends AcceptOrRejectRequestState{}
class RejectRequestLoadingState extends AcceptOrRejectRequestState{}
class AcceptTeacherRequestState extends AcceptOrRejectRequestState{
  String message;

  AcceptTeacherRequestState({required this.message});
}
class RejectTeacherRequestState extends AcceptOrRejectRequestState{
  String message;

  RejectTeacherRequestState({required this.message});
}
class AcceptOrRejectErrorState extends AcceptOrRejectRequestState{
  List<String>message;
  AcceptOrRejectErrorState({required this.message});
}