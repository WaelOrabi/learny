import 'package:dartz/dartz.dart';
import 'package:learny_project/features/appointment/domain/repositories/appointment_repository.dart';

import '../../../../core/error/failure.dart';
class ChangeStateAppointmentUseCase {
  final AppointmentRepository appointmentRepository;

  ChangeStateAppointmentUseCase({required this.appointmentRepository});
  Future<Either<Failure,Unit>>call({required int statusId, required int appointmentId})async{
    return await appointmentRepository.changeStateAppointment(appointmentId: appointmentId, statusId: statusId);
  }
}