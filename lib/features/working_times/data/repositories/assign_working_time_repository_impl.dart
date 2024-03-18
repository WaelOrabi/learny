import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../datasources/assign_working_time_data_source.dart';
import '../models/working_times_model.dart';
import '../../domain/entities/working_times_entitiy.dart';
import '../../domain/repositories/assign_working_time_repository.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';

class AssignWorkingTimeRepositoryImpl extends AssignWorkingTimeRepository {
  final AssignWorkingTimeRemoteDataSource assignWorkingTimeRemoteDataSource;
  final NetworkInfo netWorkInfo;

  AssignWorkingTimeRepositoryImpl(
      {required this.assignWorkingTimeRemoteDataSource,
      required this.netWorkInfo});

  @override
  Future<Either<Failure, Unit>> assignWorkingTime(
      {required AssignWorkingTimeModel assignWorkingTimeModel}) async {
    if (await netWorkInfo.isConnected) {
      try {
     await assignWorkingTimeRemoteDataSource
            .assignWorkingTimeRemoteDataSource(
                assignWorkingTimeModel: assignWorkingTimeModel);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
