part of 'get_student_appointments_bloc.dart';

@immutable
abstract class GetStudentAppointmentsEvent {}
class GetStudentAppointments extends GetStudentAppointmentsEvent{
  final  List<String>status;
  final int numberPage;

  GetStudentAppointments({required this.status,required this.numberPage});
}