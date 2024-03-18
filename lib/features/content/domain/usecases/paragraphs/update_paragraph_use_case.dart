import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../entities/paragraphs_entity.dart';
import '../../entities/questions_entity.dart';
import '../../repositories/content_repository.dart';

class UpdateParagraphUseCase{
  final ContentRepository contentRepository;

  UpdateParagraphUseCase({required this.contentRepository});
  Future<Either<Failure, Unit>> call({required ParagraphsEntity paragraphsEntity})async{
    return await contentRepository.updateParagraph(paragraphsEntity: paragraphsEntity);
  }
}