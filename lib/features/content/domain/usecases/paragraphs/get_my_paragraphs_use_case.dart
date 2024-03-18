import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../entities/all_paragraphs_entity.dart';
import '../../entities/paragraphs_entity.dart';
import '../../entities/questions_entity.dart';
import '../../repositories/content_repository.dart';

class GetMyParagraphsUseCase{
  final ContentRepository contentRepository;

  GetMyParagraphsUseCase({required this.contentRepository});
  Future<Either<Failure, AllParagraphsEntity>> call({required String pageId,
    required String languageId,
    required String categoryId,
    required String paragraphLevelId,})async{
    return await contentRepository.getMyParagraphs(pageId: pageId, languageId: languageId, categoryId: categoryId, paragraphLevelId: paragraphLevelId);
  }
}