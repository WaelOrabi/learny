import 'package:dartz/dartz.dart';
import 'package:learny_project/features/teachers/domain/entities/teachers_entity.dart';
import '../../../../../core/error/failure.dart';
import '../../entities/questions_entity.dart';
import '../../repositories/content_repository.dart';

class CreateQuestionUseCase{
  final ContentRepository contentRepository;

  CreateQuestionUseCase({required this.contentRepository});
  Future<Either<Failure, Unit>> call({required QuestionsEntity questionsEntity})async{
    return await contentRepository.createQuestion(questionsEntity: questionsEntity);
  }
}