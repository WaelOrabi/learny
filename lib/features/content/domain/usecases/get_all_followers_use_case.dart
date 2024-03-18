import 'package:dartz/dartz.dart';
import 'package:learny_project/features/teachers/domain/entities/teachers_entity.dart';
import '../../../../core/error/failure.dart';
import '../repositories/content_repository.dart';

class GetAllFollowersUseCase{
  final ContentRepository contentRepository;

  GetAllFollowersUseCase({required this.contentRepository});
  Future<Either<Failure,TeachersEntity>>call()async{
    return await contentRepository.getAllFollowers();
  }
}