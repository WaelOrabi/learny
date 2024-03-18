part of 'level_bloc.dart';

@immutable
abstract class LevelEvent extends Equatable{
  @override
  List<Object> get props=>[];
}


class GetAllLevelsEvent extends LevelEvent{}


class AddLevelEvent extends LevelEvent{
  final String levelName;
  final String levelDescription;

  AddLevelEvent({required this.levelName,required this.levelDescription});
  @override
  List<Object> get props=>[levelName,levelDescription];

}

class DeleteLevelEvent extends LevelEvent{
  final String levelId;

  DeleteLevelEvent({required this.levelId});
  @override
  List<Object> get props=>[levelId];

}