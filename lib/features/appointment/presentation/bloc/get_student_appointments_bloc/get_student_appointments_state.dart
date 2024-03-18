part of 'get_student_appointments_bloc.dart';

@immutable
abstract class GetStudentAppointmentsState {}

class GetStudentAppointmentsInitial extends GetStudentAppointmentsState {}
class GetStudentAppointmentsLoading extends GetStudentAppointmentsState{}
class GetStudentAppointmentsLoaded extends GetStudentAppointmentsState{
  final GetStudentAppointmentsEntity getStudentAppointmentsEntity;

  GetStudentAppointmentsLoaded({required this.getStudentAppointmentsEntity});

}
class GetStudentAppointmentsError extends GetStudentAppointmentsState{
 final List<String>message;

  GetStudentAppointmentsError({required this.message});
}