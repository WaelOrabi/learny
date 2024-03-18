part of 'accept_or_reject_appointment_bloc.dart';

@immutable
abstract class AcceptOrRejectAppointmentEvent {}
class AcceptAppointment extends AcceptOrRejectAppointmentEvent{
  int statusId;
  int appointmentId;

  AcceptAppointment({required this.statusId,required this.appointmentId});
}
class RejectAppointment extends AcceptOrRejectAppointmentEvent{
  int statusId;
  int appointmentId;

  RejectAppointment({required this.statusId,required this.appointmentId});
}