import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/language_entity.dart';

abstract class LanguageRepository{
  Future<Either<Failure,List<Language>>> getAllLanguage();
  Future<Either<Failure,Unit>> addLanguage({required String languageName});
  Future<Either<Failure,Unit>> deleteLanguage({required String languageId});
}

