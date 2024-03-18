part of 'update_booking_appointment_bloc.dart';

@immutable
abstract class UpdateBookingAppointmentState {}

class UpdateBookingAppointmentInitial extends UpdateBookingAppointmentState {}
class UpdateBookingAppointmentLoading extends UpdateBookingAppointmentState{}
class UpdateBookingAppointmentLoaded extends UpdateBookingAppointmentState{}
class UpdateBookingAppointmentError extends UpdateBookingAppointmentState{
  List<String> message;

  UpdateBookingAppointmentError({required this.message});
}