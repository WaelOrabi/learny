import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../repositories/content_repository.dart';

class DeleteParagraphUseCase{
  final ContentRepository contentRepository;

  DeleteParagraphUseCase({required this.contentRepository});
  Future<Either<Failure, Unit>> call({required String paragraphId})async{
    return await contentRepository.deleteParagraph(paragraphId: paragraphId);
  }
}