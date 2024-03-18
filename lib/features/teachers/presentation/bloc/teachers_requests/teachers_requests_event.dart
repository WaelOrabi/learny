part of 'teachers_requests_bloc.dart';

@immutable
abstract class TeachersRequestsEvent {}
class GetAllTeachersRequestsEvent extends TeachersRequestsEvent{
  final List<String> statuses;

  GetAllTeachersRequestsEvent({required this.statuses});

}