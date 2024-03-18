part of 'get_teachers_bloc.dart';

@immutable
abstract class GetTeachersState {}

class GetTeachersInitialState extends GetTeachersState {}
class GetTeachersLoadingState extends GetTeachersState{}
class GetTeachersSuccessState extends GetTeachersState{
  final TeachersEntity teachers;

  GetTeachersSuccessState({required this.teachers});

}
class GetTeachersErrorState extends GetTeachersState{
  final List<String>message;

  GetTeachersErrorState({required this.message});

}