part of 'booking_appointment_bloc.dart';

@immutable
abstract class BookingAppointmentState {}

class BookingAppointmentInitial extends BookingAppointmentState {}
class BookingAppointmentLoading extends BookingAppointmentState{}
class BookingAppointmentLoaded extends BookingAppointmentState{}
class BookingAppointmentError extends BookingAppointmentState{
  List<String>message;

  BookingAppointmentError({required this.message});
}
class DeleteAttachmentsState extends BookingAppointmentState{
 final  List<AttachmentsEntity> attachments;

 DeleteAttachmentsState({required this.attachments});
}
class AddAttachmentsState extends BookingAppointmentState{
  final List<AttachmentsEntity>attachments;

  AddAttachmentsState({required this.attachments});
}