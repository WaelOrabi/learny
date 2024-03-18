
import 'package:dartz/dartz.dart';
import 'package:learny_project/features/content/data/models/all_paragraphs_model.dart';
import 'package:learny_project/features/content/domain/entities/all_paragraphs_entity.dart';

import '../../../../../core/error/failure.dart';
import '../../entities/paragraphs_entity.dart';
import '../../repositories/content_repository.dart';

class GetAllParagraphsUseCase{
  final ContentRepository contentRepository;

  GetAllParagraphsUseCase({required this.contentRepository});
  Future<Either<Failure, AllParagraphsEntity>> call({required String pageId,
    required String languageId,
    required String categoryId,
    required String paragraphLevelId,})async{
    return await contentRepository.getAllParagraphs(pageId: pageId, languageId: languageId, categoryId: categoryId, paragraphLevelId: paragraphLevelId);
  }
}