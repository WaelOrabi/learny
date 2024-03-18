part of 'get_goals_bloc.dart';

@immutable
abstract class GetGoalsState {}

class GetGoalsInitial extends GetGoalsState {}
class GetAllGoalsLoading extends GetGoalsState{}
class GetAllGoalsState extends GetGoalsState{
  final GoalsEntity goalsEntity;

  GetAllGoalsState({required this.goalsEntity});
}
class GetAllGoalsError extends GetGoalsState{
  final List<String>message;

  GetAllGoalsError({required this.message});

}