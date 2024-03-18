import 'package:dartz/dartz.dart';
import 'package:learny_project/features/home/domain/entities/packages_hours_%20price_entity.dart';
import 'package:learny_project/features/home/domain/entities/services_entity.dart';
import 'package:learny_project/features/home/domain/entities/statistics_entity.dart';

import '../../../../core/error/failure.dart';
import '../entities/get_best_teachers_entity.dart';
import '../entities/info_home_entity.dart';

abstract class RepositoryHome{
  Future<Either<Failure,InfoHomeEntity>>getInfo();
  Future<Either<Failure,PackagesHoursPriceEntity>>getPakagesHoursPriceEntity();
  Future<Either<Failure,ServicesEntity>>getServices();
  Future<Either<Failure,StatisticsEntity>>getStatistics();
  Future<Either<Failure,GetBestTeachersEntity>>getBestTeacher();
}