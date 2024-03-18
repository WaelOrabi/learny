import 'package:dartz/dartz.dart';
import 'package:learny_project/features/appointment/domain/entities/get_student_appointment_entity.dart';
import 'package:learny_project/features/appointment/domain/repositories/appointment_repository.dart';

import '../../../../core/error/failure.dart';

class GetStudentAppointmentUseCase{
 final  AppointmentRepository appointmentRepository;

  GetStudentAppointmentUseCase({required this.appointmentRepository});
  Future<Either<Failure, GetStudentAppointmentEntity>>call({required int idAppointment})async{
    return await appointmentRepository.getStudentAppointment(idAppointment: idAppointment);
  }

}