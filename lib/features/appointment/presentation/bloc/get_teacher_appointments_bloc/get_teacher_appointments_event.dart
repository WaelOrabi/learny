part of 'get_teacher_appointments_bloc.dart';

@immutable
abstract class GetTeacherAppointmentsEvent {}
class GetTeacherAppointments extends GetTeacherAppointmentsEvent{
  List<String>statuses;
  int pageNumber;

  GetTeacherAppointments({required this.statuses, required this.pageNumber});
}