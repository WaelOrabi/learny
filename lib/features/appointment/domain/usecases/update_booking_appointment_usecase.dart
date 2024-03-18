import 'package:dartz/dartz.dart';
import 'package:learny_project/features/appointment/domain/entities/update_booking_appointment_entity.dart';
import 'package:learny_project/features/appointment/domain/repositories/appointment_repository.dart';

import '../../../../core/error/failure.dart';

class UpdateBookingAppointmentUseCase{
  final AppointmentRepository appointmentRepository;

  UpdateBookingAppointmentUseCase({required this.appointmentRepository});
  Future<Either<Failure,Unit>>call({required UpdateBookingAppointmentEntity updateBookingAppointmentEntity})async{
    return await appointmentRepository.updateBookingAppointment(updateBookingAppointmentEntity: updateBookingAppointmentEntity);
  }

}