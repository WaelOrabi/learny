import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../entities/questions_entity.dart';
import '../../repositories/content_repository.dart';

class GetQuestionUseCase{
  final ContentRepository contentRepository;

  GetQuestionUseCase({required this.contentRepository});
  Future<Either<Failure, QuestionsEntity>> call({required String questionId})async{
    return await contentRepository.getQuestion(questionId: questionId);
  }
}