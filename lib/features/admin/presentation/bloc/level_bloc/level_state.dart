part of 'level_bloc.dart';

@immutable
abstract class LevelState extends Equatable{
  @override
  List<Object> get props=>[];
}


class LevelInitial extends LevelState {}


class GetAllLevelsLoadingState extends LevelState {}

class GetAllLevelsSuccessState extends LevelState {
  final List<Level> listAllLevels;

  GetAllLevelsSuccessState({required this.listAllLevels});
}

class GetAllLevelsErrorState extends LevelState {
  final List<String> message;

  GetAllLevelsErrorState({required this.message});
  @override
  List<Object>get props=>[message];
}



class AddLevelLoadingState extends LevelState {}

class AddLevelSuccessState extends LevelState {}

class AddLevelErrorState extends LevelState {
  final List<String> message;

  AddLevelErrorState({required this.message});
  @override
  List<Object>get props=>[message];
}




class DeleteLevelLoadingState extends LevelState {}

class DeleteLevelSuccessState extends LevelState {}

class DeleteLevelErrorState extends LevelState {
  final List<String> message;

  DeleteLevelErrorState({required this.message});
  @override
  List<Object>get props=>[message];
}
