part of 'get_teacher_appointments_bloc.dart';

@immutable
abstract class GetTeacherAppointmentsState {}

class GetTeacherAppointmentsInitial extends GetTeacherAppointmentsState {}
class GetTeacherAppointmentsLoading extends GetTeacherAppointmentsState{}
class GetTeacherAppointmentsLoaded extends GetTeacherAppointmentsState{
  final GetTeacherAppointmentsEntity getTeacherAppointmentsEntity;

  GetTeacherAppointmentsLoaded({required this.getTeacherAppointmentsEntity});
}
class GetTeacherAppointmentsError extends GetTeacherAppointmentsState{
  final List<String>message;

  GetTeacherAppointmentsError({required this.message});
}