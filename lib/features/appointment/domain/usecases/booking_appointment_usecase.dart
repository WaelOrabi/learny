import 'package:dartz/dartz.dart';
import 'package:learny_project/core/error/failure.dart';
import 'package:learny_project/features/appointment/domain/repositories/appointment_repository.dart';

import '../entities/booking_appointment_entity.dart';

class BookingAppointmentUseCase{
 final  AppointmentRepository appointmentRepository;

  BookingAppointmentUseCase({required this.appointmentRepository});
Future<Either<Failure,Unit>>call({required BookingAppointmentEntity bookingAppointmentEntity})async{
  return await appointmentRepository.bookingAppointment(bookingAppointmentEntity: bookingAppointmentEntity);
}
}
