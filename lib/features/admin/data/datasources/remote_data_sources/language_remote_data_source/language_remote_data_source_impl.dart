import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'language_remote_data_source.dart';
import '../../../models/language_model.dart';

import '../../../../../../core/error/exception.dart';
import '../../../../../../core/strings/api_end_point.dart';
import '../../../../../auth/data/datasources/local_data_sources/auth_local_data_sources.dart';
import '../../../../../auth/data/datasources/remote_data_sources/helper_function_auth_remote_data_sourcess.dart';
import '../../../../../auth/data/models/user_model.dart';

class LanguageRemoteDateSourceImpl implements LanguageRemoteDataSource{
  late final Dio dio;

  LanguageRemoteDateSourceImpl(){

    BaseOptions baseOptions = BaseOptions(
      baseUrl: BASE_URL,
      receiveDataWhenStatusError: true,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    dio = Dio(baseOptions);
  }

  @override
  Future<Unit> addLanguage({required String languageName}) {
    // TODO: implement addLanguage
    throw UnimplementedError();
  }

  @override
  Future<Unit> deleteLanguage({required String languageId}) {
    // TODO: implement deleteLanguage
    throw UnimplementedError();
  }

  @override
  Future<List<LanguageModel>> getAllLanguages() async {


    try {
      final response = await dio.get(GET_LANGUAGES);
      if (response.statusCode == 200) {
        List<LanguageModel> list = [];
        for (int i = 0; i < response.data['data'].length; i++) {
          list.add(LanguageModel.fromJson(response.data['data'][i]));
        }
        return list;
      } else {
        throw ServerException();
      }
    } on DioException catch (error) {
      handleDioError(error);
    } catch (error) {
      throw ServerException();
    }
    throw ServerException();
  }

}