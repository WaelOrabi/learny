import 'package:dartz/dartz.dart';
import 'package:learny_project/features/home/domain/entities/statistics_entity.dart';

import '../../../../core/error/failure.dart';
import '../repositories/repository_home.dart';

class StatisticsUseCase{
  final RepositoryHome repositoryHome;

  StatisticsUseCase({required this.repositoryHome});

  Future<Either<Failure,StatisticsEntity>>call()async{
    return await repositoryHome.getStatistics();
  }
}