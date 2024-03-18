part of 'update_booking_appointment_bloc.dart';

@immutable
abstract class UpdateBookingAppointmentEvent {}
class UpdateBookingAppointment extends UpdateBookingAppointmentEvent{
final UpdateBookingAppointmentEntity updateBookingAppointmentEntity;

UpdateBookingAppointment({required this.updateBookingAppointmentEntity});
}