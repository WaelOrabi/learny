part of 'get_student_appointment_bloc.dart';

@immutable
abstract class GetStudentAppointmentEvent {}
class GetStudentAppointment extends GetStudentAppointmentEvent{
  final int idAppointment;

  GetStudentAppointment({required this.idAppointment});

}
