import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../entities/paragraphs_entity.dart';
import '../../entities/questions_entity.dart';
import '../../repositories/content_repository.dart';

class GetParagraphUseCase{
  final ContentRepository contentRepository;

  GetParagraphUseCase({required this.contentRepository});
  Future<Either<Failure, ParagraphsEntity>> call({required String paragraphId})async{
    return await contentRepository.getParagraph(paragraphId: paragraphId);
  }
}