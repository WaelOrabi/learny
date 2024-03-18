import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../entities/questions_entity.dart';
import '../../repositories/content_repository.dart';

class UpdateQuestionUseCase{
  final ContentRepository contentRepository;

  UpdateQuestionUseCase({required this.contentRepository});
  Future<Either<Failure, Unit>> call({required QuestionsEntity questionsEntity})async{
    return await contentRepository.updateQuestion(questionsEntity: questionsEntity);
  }
}