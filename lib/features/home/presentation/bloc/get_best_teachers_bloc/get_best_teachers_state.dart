part of 'get_best_teachers_bloc.dart';

@immutable
abstract class GetBestTeachersState {}

class GetBestTeachersInitialState extends GetBestTeachersState {}
class GetBestTeachersLoadingState extends GetBestTeachersState{}
class GetBestTeachersLoadedState extends GetBestTeachersState{
  final GetBestTeachersEntity getBestTeachersEntity;

  GetBestTeachersLoadedState({required this.getBestTeachersEntity});
}
class GetBestTeacherErrorState extends GetBestTeachersState{
  final List<String>message;

  GetBestTeacherErrorState({required this.message});
}