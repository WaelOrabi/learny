import 'package:dartz/dartz.dart';

import 'package:learny_project/core/error/failure.dart';
import 'package:learny_project/features/home/data/datasources/remote_data_sources/home_data_source.dart';
import 'package:learny_project/features/home/domain/entities/get_best_teachers_entity.dart';

import 'package:learny_project/features/home/domain/entities/info_home_entity.dart';

import 'package:learny_project/features/home/domain/entities/packages_hours_%20price_entity.dart';

import 'package:learny_project/features/home/domain/entities/services_entity.dart';

import 'package:learny_project/features/home/domain/entities/statistics_entity.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/repository_home.dart';

class RepositoryHomeImpl extends RepositoryHome {
  final HomeDataSource homeDataSource;
  final NetworkInfo networkInfo;

  RepositoryHomeImpl({required this.homeDataSource, required this.networkInfo});

  Future<Either<Failure, T>> _getEntity<T>(
      Future<T> Function() getDataSourceData) async {
    if (await networkInfo.isConnected) {
      try {
        final T result = await getDataSourceData();
        return Right(result);
      } catch (error) {
        return _handleError(error);
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  Either<Failure, T> _handleError<T>(error) {
    if (error is WrongDataException) {
      return Left(WrongDataFailure(messages: error.messages));
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, InfoHomeEntity>> getInfo() {
    return _getEntity(homeDataSource.getInfoDataSource);
  }

  @override
  Future<Either<Failure, PackagesHoursPriceEntity>>
  getPakagesHoursPriceEntity() {
    return _getEntity(homeDataSource.getPackagesHoursPriceDataSource);
  }

  @override
  Future<Either<Failure, ServicesEntity>> getServices() {
    return _getEntity(homeDataSource.getServicesDataSource);
  }

  @override
  Future<Either<Failure, StatisticsEntity>> getStatistics() {
    return _getEntity(homeDataSource.getStatisticsDataSource);
  }

  @override
  Future<Either<Failure, GetBestTeachersEntity>> getBestTeacher() {
   return _getEntity(homeDataSource.getBestTeachersDataSource);
  }
}
