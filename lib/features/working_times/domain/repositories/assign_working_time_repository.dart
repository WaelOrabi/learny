import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../data/models/working_times_model.dart';

import '../entities/working_times_entitiy.dart';

abstract class AssignWorkingTimeRepository{
  Future<Either<Failure,Unit>>assignWorkingTime({required AssignWorkingTimeModel assignWorkingTimeModel});
}