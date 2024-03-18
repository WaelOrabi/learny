import 'package:dartz/dartz.dart';
import 'package:learny_project/features/appointment/domain/entities/get_teacher_appointment_entity.dart';
import 'package:learny_project/features/appointment/domain/repositories/appointment_repository.dart';

import '../../../../core/error/failure.dart';

class GetTeacherAppointmentUseCase {
  final AppointmentRepository appointmentRepository;

  GetTeacherAppointmentUseCase({required this.appointmentRepository});
  Future<Either<Failure,GetTeacherAppointmentEntity>>call({required int idAppointment})async{
    return await appointmentRepository.getTeacherAppointment(idAppointment: idAppointment);
  }

}