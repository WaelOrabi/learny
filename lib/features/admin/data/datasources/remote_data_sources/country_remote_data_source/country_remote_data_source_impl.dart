import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../models/country_model.dart';
import '../../../../../../core/error/exception.dart';
import '../../../../../../core/strings/api_end_point.dart';
import '../../../../../auth/data/datasources/local_data_sources/auth_local_data_sources.dart';
import '../../../../../auth/data/datasources/remote_data_sources/helper_function_auth_remote_data_sourcess.dart';
import '../../../../../auth/data/models/user_model.dart';
import 'country_remote_data_source.dart';

class CountryRemoteDataSourceImpl implements CountryRemoteDataSource{
  final AuthLocalDataSources authLocalDataSources;
  late final Dio dio;

  CountryRemoteDataSourceImpl({required this.authLocalDataSources}){
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
  Future<Unit> addCountry({required String countryName}) {
    // TODO: implement addCountry
    throw UnimplementedError();
  }

  @override
  Future<Unit> deleteCountry({required String countryId}) {
    // TODO: implement deleteCountry
    throw UnimplementedError();
  }

  @override
  Future<List<CountryModel>> getAllCountries()async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers.addAll({
      'Authorization': "Bearer ${userModel.accessToken}"
    });


    try {
      final response = await dio.get(GET_COUNTRIES);
      if (response.statusCode == 200) {
        List<CountryModel> list = [];
        for (int i = 0; i < response.data['data'].length; i++) {
          list.add(CountryModel.fromJson(response.data['data'][i]));
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