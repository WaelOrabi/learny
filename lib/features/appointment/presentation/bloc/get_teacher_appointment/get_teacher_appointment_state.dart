part of 'get_teacher_appointment_bloc.dart';

@immutable
abstract class GetTeacherAppointmentState {}

class GetTeacherAppointmentInitial extends GetTeacherAppointmentState {}
class GetTeacherAppointmentLoading extends GetTeacherAppointmentState{}
class GetTeacherAppointmentLoaded extends GetTeacherAppointmentState{
  final GetTeacherAppointmentEntity getTeacherAppointmentEntity;

  GetTeacherAppointmentLoaded({required this.getTeacherAppointmentEntity});

}
class GetTeacherAppointmentError extends GetTeacherAppointmentState{
  final List<String>message;

  GetTeacherAppointmentError({required this.message});
}
