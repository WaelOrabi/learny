import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../../core/error/exception.dart';
import '../../../../../../core/strings/api_end_point.dart';
import '../../../../../auth/data/datasources/local_data_sources/auth_local_data_sources.dart';
import '../../../../../auth/data/datasources/remote_data_sources/helper_function_auth_remote_data_sourcess.dart';
import '../../../../../auth/data/models/user_model.dart';
import '../../../models/donor_type_model.dart';
import 'donor_type_remote_data_source.dart';

class DonorTypeRemoteDataSourceImpl implements DonorTypeRemoteDataSource{
   final AuthLocalDataSources authLocalDataSources;
  late final Dio dio;

  DonorTypeRemoteDataSourceImpl({required this.authLocalDataSources}){
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
  Future<Unit> addDonorType({required String donorTypeName}) {
    // TODO: implement addDonorType
    throw UnimplementedError();
  }

  @override
  Future<Unit> deleteDonorType({required String donorTypeId}) {
    // TODO: implement deleteDonorType
    throw UnimplementedError();
  }

  @override
  Future<List<DonorTypeModel>> getAllDonorTypes()async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers.addAll({
      'Authorization': "Bearer ${userModel.accessToken}"
    });


    try {
      final response = await dio.get(GET_DONOR_TYPES);
      if (response.statusCode == 200) {
        List<DonorTypeModel> list = [];
        for (int i = 0; i < response.data['data'].length; i++) {
          list.add(DonorTypeModel.fromJson(response.data['data'][i]));
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