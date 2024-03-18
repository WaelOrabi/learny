import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../entities/questions_entity.dart';
import '../../repositories/content_repository.dart';

class DeleteQuestionUseCase{
  final ContentRepository contentRepository;

  DeleteQuestionUseCase({required this.contentRepository});
  Future<Either<Failure, Unit>> call({required String questionId})async{
    return await contentRepository.deleteQuestion(questionId: questionId);
  }
}