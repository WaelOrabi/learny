part of 'services_bloc.dart';

@immutable
abstract class ServicesState {}

class ServicesInitial extends ServicesState {}
class ServicesLoadingState extends ServicesState{}
class ServicesLoadedState extends ServicesState{
  final ServicesEntity services;

  ServicesLoadedState({required this.services});
}
class ServicesErrorState extends ServicesState{
  final List<String>message;

  ServicesErrorState({required this.message});
}