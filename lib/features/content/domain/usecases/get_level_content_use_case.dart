import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/category_question.dart';
import '../entities/level_content.dart';
import '../repositories/content_repository.dart';

class GetLevelContentUseCase{
  final ContentRepository contentRepository;

  GetLevelContentUseCase({required this.contentRepository});
  Future<Either<Failure,List<LevelContentEntity>>>call()async{
    return await contentRepository.getLevelContent();
  }
}