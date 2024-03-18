import 'package:dartz/dartz.dart';
import '../../../../teachers/domain/repositories/teacher_repository.dart';
import '../../../../../core/error/failure.dart';
import '../../repositories/language_repository.dart';

class DeleteLanguageUseCase{
  final LanguageRepository repository;
  DeleteLanguageUseCase(this.repository);
  Future<Either<Failure,Unit>> call({required String languageId})async{
    return await repository.deleteLanguage(languageId:languageId );
  }

}