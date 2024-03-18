import 'package:dartz/dartz.dart';
import 'package:learny_project/features/appointment/domain/repositories/appointment_repository.dart';

import '../../../../core/error/failure.dart';
class DeleteBookingAppointmentUseCase{
  final AppointmentRepository appointmentRepository;

  DeleteBookingAppointmentUseCase({required this.appointmentRepository});
  Future<Either<Failure,Unit>>call({required idAppointment})async{
  return   await appointmentRepository.deleteAppointment(idAppointment: idAppointment);
  }
}