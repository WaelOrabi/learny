import 'package:dartz/dartz.dart';
import 'package:learny_project/core/error/failure.dart';
import 'package:learny_project/features/appointment/domain/entities/get_student_appointments_entity.dart';
import 'package:learny_project/features/appointment/domain/repositories/appointment_repository.dart';

class GetStudentAppointmentsUseCase{
  final AppointmentRepository appointmentRepository;

  GetStudentAppointmentsUseCase({required this.appointmentRepository});
  Future<Either<Failure, GetStudentAppointmentsEntity>>call({required List<String>status, required int numberPage})async{
    return await appointmentRepository.getStudentAppointments(status: status, numberPage: numberPage);
  }
}