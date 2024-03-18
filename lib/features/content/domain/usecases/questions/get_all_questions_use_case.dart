import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../entities/all_questions_entity.dart';
import '../../entities/questions_entity.dart';
import '../../repositories/content_repository.dart';

class GetAllQuestionsUseCase{
  final ContentRepository contentRepository;

  GetAllQuestionsUseCase({required this.contentRepository});
  Future<Either<Failure, AllQuestionsEntity>> call({required String pageId,
    required String languageId,
    required String categoryId,
    required String questionLevelId,})async{
    return await contentRepository.getAllQuestions(pageId: pageId, languageId: languageId, categoryId: categoryId, questionLevelId: questionLevelId);
  }
}