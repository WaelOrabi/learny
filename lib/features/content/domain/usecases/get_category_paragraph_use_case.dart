import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/category_paragraph.dart';
import '../entities/category_question.dart';
import '../repositories/content_repository.dart';

class GetCategoryParagraphUseCase{
  final ContentRepository contentRepository;

  GetCategoryParagraphUseCase({required this.contentRepository});
  Future<Either<Failure,List<CategoryParagraphEntity>>>call()async{
    return await contentRepository.getCategoryParagraph();
  }
}