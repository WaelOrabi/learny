part of 'delete_appointment_bloc.dart';

abstract class DeleteAppointmentEvent {}
class DeleteAppointment extends DeleteAppointmentEvent{
  final String idAppointment;

   DeleteAppointment({required this.idAppointment});


}