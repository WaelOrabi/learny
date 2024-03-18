import 'package:dartz/dartz.dart';
import 'package:learny_project/features/content/domain/entities/all_questions_entity.dart';
import '../../../../../core/error/failure.dart';
import '../../entities/questions_entity.dart';
import '../../repositories/content_repository.dart';

class GetMyQuestionsUseCase{
  final ContentRepository contentRepository;

  GetMyQuestionsUseCase({required this.contentRepository});
  Future<Either<Failure, AllQuestionsEntity>> call({required String pageId,
    required String languageId,
    required String categoryId,
    required String questionLevelId,})async{
    return await contentRepository.getMyQuestions(pageId: pageId, languageId: languageId, categoryId: categoryId, questionLevelId: questionLevelId);
  }
}