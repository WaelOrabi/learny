import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../datasources/remote_data_sources/language_remote_data_source/language_remote_data_source.dart';
import '../../domain/entities/language_entity.dart';
import '../../domain/repositories/language_repository.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';

class LanguageRepositoriesImpl implements LanguageRepository{
  final LanguageRemoteDataSource languageRemoteDataSource;
  final NetworkInfo networkInfo;

  LanguageRepositoriesImpl({required this.languageRemoteDataSource,required this.networkInfo});
  @override
  Future<Either<Failure, Unit>> addLanguage({required String languageName}) {
    // TODO: implement addLanguage
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> deleteLanguage({required String languageId}) {
    // TODO: implement deleteLanguage
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Language>>> getAllLanguage()  async {
    if (await networkInfo.isConnected) {
      try {
        final  languages=  await languageRemoteDataSource.getAllLanguages();
        return  Right(languages);
      } catch (error) {
        if (error is WrongDataException) {
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }

}