
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../entities/paragraphs_entity.dart';
import '../../repositories/content_repository.dart';

class CreateParagraphUseCase{
  final ContentRepository contentRepository;

  CreateParagraphUseCase({required this.contentRepository});
  Future<Either<Failure, Unit>> call({required ParagraphsEntity paragraphsEntity})async{
    return await contentRepository.createParagraph(paragraphsEntity: paragraphsEntity);
  }
}