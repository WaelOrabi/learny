import 'package:dartz/dartz.dart';
import 'package:learny_project/features/home/domain/entities/packages_hours_%20price_entity.dart';

import '../../../../core/error/failure.dart';
import '../repositories/repository_home.dart';

class PackagesHoursPriceUseCase{
  final RepositoryHome repositoryHome;

  PackagesHoursPriceUseCase({required this.repositoryHome});

  Future<Either<Failure,PackagesHoursPriceEntity>>call()async{
    return await repositoryHome.getPakagesHoursPriceEntity();
  }
}