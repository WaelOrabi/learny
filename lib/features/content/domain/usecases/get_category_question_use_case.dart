import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/category_question.dart';
import '../repositories/content_repository.dart';

class GetCategoryQuestionUseCase{
  final ContentRepository contentRepository;

  GetCategoryQuestionUseCase({required this.contentRepository});
  Future<Either<Failure,List<CategoryQuestionEntity>>>call()async{
    return await contentRepository.getCategoryQuestion();
  }
}