import 'package:dartz/dartz.dart';

import '../../../models/language_model.dart';

abstract class LanguageRemoteDataSource{
  Future<List<LanguageModel>>getAllLanguages();
  Future<Unit> addLanguage({required String languageName});
  Future<Unit> deleteLanguage({required String languageId});
}