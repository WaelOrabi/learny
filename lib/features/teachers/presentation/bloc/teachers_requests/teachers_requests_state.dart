part of 'teachers_requests_bloc.dart';

@immutable
abstract class TeachersRequestsState {}

class TeachersRequestsInitial extends TeachersRequestsState {}
class GetAllTeachersRequestsLoading extends TeachersRequestsState {}
class GetAllTeachersRequestsSuccess extends TeachersRequestsState {
  final List<TeachersRequestsEntity> list;

  GetAllTeachersRequestsSuccess({required this.list});
}
class GetAllTeachersRequestsError extends TeachersRequestsState {
final List<String> messages;

  GetAllTeachersRequestsError(this.messages);
}
