part of 'get_student_appointment_bloc.dart';

@immutable
abstract class GetStudentAppointmentState {}

class GetStudentAppointmentInitial extends GetStudentAppointmentState {}
class GetStudentAppointmentLoading extends GetStudentAppointmentState{}
class GetStudentAppointmentLoaded extends GetStudentAppointmentState{
  final GetStudentAppointmentEntity getStudentAppointmentEntity;

  GetStudentAppointmentLoaded({required this.getStudentAppointmentEntity});

}
class GetStudentAppointmentError extends GetStudentAppointmentState{
  final List<String>message;

  GetStudentAppointmentError({required this.message});

}