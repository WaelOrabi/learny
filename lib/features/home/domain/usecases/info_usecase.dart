import 'package:dartz/dartz.dart';
import 'package:learny_project/features/home/domain/entities/info_home_entity.dart';
import 'package:learny_project/features/home/domain/repositories/repository_home.dart';

import '../../../../core/error/failure.dart';

class InfoUseCase{
  final RepositoryHome repositoryHome;

  InfoUseCase({required this.repositoryHome});

  Future<Either<Failure,InfoHomeEntity>>call()async{
    return await repositoryHome.getInfo();
  }
}