import 'package:dartz/dartz.dart';
import 'package:learny_project/features/home/domain/entities/get_best_teachers_entity.dart';

import '../../../../core/error/failure.dart';
import '../repositories/repository_home.dart';

class GetBestTeachersUseCase {
  final RepositoryHome repositoryHome;

  GetBestTeachersUseCase({required this.repositoryHome});

  Future<Either<Failure,GetBestTeachersEntity>>call()async{
    return await repositoryHome.getBestTeacher();
  }
}