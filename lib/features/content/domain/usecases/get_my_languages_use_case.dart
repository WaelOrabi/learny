import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../admin/domain/entities/language_entity.dart';
import '../repositories/content_repository.dart';

class GetMyLanguagesUseCase{
  final ContentRepository contentRepository;

  GetMyLanguagesUseCase({required this.contentRepository});
  Future<Either<Failure, List<Language>>> call()async{
    return await contentRepository.getMyLanguages();
  }
}