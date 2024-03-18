import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../entities/questions_entity.dart';
import '../../repositories/content_repository.dart';

class SolveQuestionUseCase{
  final ContentRepository contentRepository;

  SolveQuestionUseCase({required this.contentRepository});
  Future<Either<Failure, Unit>> call({  required String questionId, required String answerId})async{
    return await contentRepository.solveQuestion(questionId: questionId, answerId: answerId);
  }
}