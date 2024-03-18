import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'level_remote_data_source.dart';
import '../../../models/level_model.dart';

import '../../../../../../core/error/exception.dart';
import '../../../../../../core/strings/api_end_point.dart';
import '../../../../../auth/data/datasources/local_data_sources/auth_local_data_sources.dart';
import '../../../../../auth/data/datasources/remote_data_sources/helper_function_auth_remote_data_sourcess.dart';
import '../../../../../auth/data/models/user_model.dart';

class LevelRemoteDateSourceImpl implements LevelRemoteDataSource{
  final AuthLocalDataSources authLocalDataSources;
  late final Dio dio;

  LevelRemoteDateSourceImpl({required this.authLocalDataSources}){
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
  Future<Unit> addLevel({required String levelName, required String levelDescription}) {
    // TODO: implement addLevel
    throw UnimplementedError();
  }

  @override
  Future<Unit> deleteLevel({required String levelId}) {
    // TODO: implement deleteLevel
    throw UnimplementedError();
  }

  @override
  Future<List<LevelModel>> getAllLevels() async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers.addAll({
      'Authorization': "Bearer ${userModel.accessToken}"
    });



    try {
      final response = await dio.get(GET_LEVELS);
      if (response.statusCode == 200) {
        List<LevelModel> list = [];
        for (int i = 0; i < response.data['data'].length; i++) {
          list.add(LevelModel.fromJson(response.data['data'][i]));
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