part of 'get_teacher_appointment_bloc.dart';

@immutable
abstract class GetTeacherAppointmentEvent {}
class GetTeacherAppointment extends GetTeacherAppointmentEvent{
  final int idAppointment;

  GetTeacherAppointment({required this.idAppointment});
}

