part of 'booking_appointment_bloc.dart';

@immutable
abstract class BookingAppointmentEvent {}
class BookingAppointment extends BookingAppointmentEvent{
  BookingAppointmentEntity bookingAppointmentEntity;

  BookingAppointment({required this.bookingAppointmentEntity});
}
class DeleteAttachments extends BookingAppointmentEvent{
  final int attachmentsId;

  DeleteAttachments({required this.attachmentsId});
}
class AddAttachments extends BookingAppointmentEvent{
  final AttachmentsEntity attachments;

  AddAttachments({required this.attachments});
}