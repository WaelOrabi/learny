part of 'accept_or_reject_request_bloc.dart';

@immutable
abstract class AcceptOrRejectRequestEvent {}
class AcceptTeacherRequestEvent extends AcceptOrRejectRequestEvent{
  String status;
  String teacherId;

  AcceptTeacherRequestEvent({required this.status,required this.teacherId});
}
class RejectTeacherRequestEvent extends AcceptOrRejectRequestEvent{
  String status;
  String teacherId;

  RejectTeacherRequestEvent({required this.status,required this.teacherId});
}