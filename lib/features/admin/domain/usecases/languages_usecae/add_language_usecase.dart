import 'package:dartz/dartz.dart';
import '../../repositories/admin_repository.dart';
import '../../repositories/country_repository.dart';
import '../../repositories/language_repository.dart';
import '../../../../teachers/domain/repositories/teacher_repository.dart';
import '../../../../../core/error/failure.dart';

class AddLanguageUseCase{
  final LanguageRepository repository;
  AddLanguageUseCase(this.repository);
  Future<Either<Failure,Unit>> call({required String languageName})async{
    return await repository.addLanguage(languageName:languageName );
  }

}