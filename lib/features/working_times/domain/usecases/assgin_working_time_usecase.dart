import 'package:dartz/dartz.dart';
import '../entities/working_times_entitiy.dart';
import '../repositories/assign_working_time_repository.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/working_times_model.dart';

class AssignWorkingTimeUseCase{
  AssignWorkingTimeRepository assignWorkingTimeRepository;

  AssignWorkingTimeUseCase({required this.assignWorkingTimeRepository});
  Future<Either<Failure,Unit>>call({required AssignWorkingTimeModel assignWorkingTimeModel})async{
    return await assignWorkingTimeRepository.assignWorkingTime(assignWorkingTimeModel: assignWorkingTimeModel);
  }
}