part of 'get_teacher_bloc.dart';

@immutable
abstract class GetTeacherEvent {}
class GetTeacher extends GetTeacherEvent{
  final int teacherId;

  GetTeacher({required this.teacherId});

}
