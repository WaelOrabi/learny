part of 'get_teacher_bloc.dart';

@immutable
abstract class GetTeacherState {}

class GetTeacherInitialState extends GetTeacherState {}
class GetTeacherLoadingState extends GetTeacherState{}
class GetTeacherSuccessState extends GetTeacherState{
  final TeacherEntity teacher;

  GetTeacherSuccessState({required this.teacher});

}
class GetTeacherErrorState extends GetTeacherState{
  final List<String>message;

  GetTeacherErrorState({required this.message});

}