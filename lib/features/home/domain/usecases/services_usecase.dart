import 'package:dartz/dartz.dart';
import 'package:learny_project/features/home/domain/entities/services_entity.dart';

import '../../../../core/error/failure.dart';
import '../repositories/repository_home.dart';

class ServicesUseCase{
  final RepositoryHome repositoryHome;

  ServicesUseCase({required this.repositoryHome});

  Future<Either<Failure,ServicesEntity>>call()async{
    return await repositoryHome.getServices();
  }
}