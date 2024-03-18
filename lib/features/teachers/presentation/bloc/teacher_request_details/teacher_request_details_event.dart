part of 'teacher_request_details_bloc.dart';

@immutable
abstract class TeacherRequestDetailsEvent{}
class RequestTeacherDetailsEvent extends TeacherRequestDetailsEvent{
  int teacherId;

  RequestTeacherDetailsEvent({required this.teacherId});
}
