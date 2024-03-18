import 'package:dartz/dartz.dart';
import '../../entities/country_entity.dart';
import '../../entities/language_entity.dart';
import '../../repositories/language_repository.dart';
import '../../../../teachers/domain/repositories/teacher_repository.dart';
import '../../../../../core/error/failure.dart';
import '../../repositories/country_repository.dart';

class GetAllLanguagesUseCase{
  final LanguageRepository repository;
  GetAllLanguagesUseCase(this.repository);
  Future<Either<Failure,List<Language>>> call()async{
    return await repository.getAllLanguage();
  }

}