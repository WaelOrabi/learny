import 'package:dartz/dartz.dart';
import 'package:learny_project/features/appointment/domain/entities/get_teacher_appointments_entity.dart';
import 'package:learny_project/features/appointment/domain/repositories/appointment_repository.dart';

import '../../../../core/error/failure.dart';

class GetTeacherAppointmentsUseCase{
  final AppointmentRepository appointmentRepository;

  GetTeacherAppointmentsUseCase({required this.appointmentRepository});
  Future<Either<Failure,GetTeacherAppointmentsEntity>>call(
      {required List<String>status, required int numberPage})async{
    return await appointmentRepository.getTeacherAppointments(status: status, numberPage: numberPage);
  }
}