import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/get_goals_entity.dart';
import '../repositories/appointment_repository.dart';

class GetGoalsUseCase{
  final AppointmentRepository appointmentRepository;

  GetGoalsUseCase({required this.appointmentRepository});
  Future<Either<Failure,GoalsEntity>>call()async{
    return await appointmentRepository.getGoals();
  }
}