part of 'info_home_bloc.dart';

@immutable
abstract class InfoHomeState {}

class InfoHomeInitial extends InfoHomeState {}
class InfoHomeLoading extends InfoHomeState{}
class InfoHomeLoaded extends InfoHomeState{
  final InfoHomeEntity infoHomeEntity;

  InfoHomeLoaded({required this.infoHomeEntity});
}
class InfoHomeError extends InfoHomeState{
  final List<String>message;

  InfoHomeError({required this.message});
}