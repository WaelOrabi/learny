import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'certificate_type_remote_data_source.dart';
import '../../../models/certificate_type_model.dart';

import '../../../../../../core/error/exception.dart';
import '../../../../../../core/strings/api_end_point.dart';
import '../../../../../auth/data/datasources/local_data_sources/auth_local_data_sources.dart';
import '../../../../../auth/data/datasources/remote_data_sources/helper_function_auth_remote_data_sourcess.dart';
import '../../../../../auth/data/models/user_model.dart';

class CertificateTypeRemoteDataSourceImpl implements CertificateTypeRemoteDataSource {
  final AuthLocalDataSources authLocalDataSources;
  late final Dio dio;


  CertificateTypeRemoteDataSourceImpl({required this.authLocalDataSources}) {
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
  Future<Unit> addCertificateType({required String certificateTypeName}) {
    // TODO: implement addCertificateType
    throw UnimplementedError();
  }

  @override
  Future<Unit> deleteCertificateType({required String certificateTypeId}) {
    // TODO: implement deleteCertificateType
    throw UnimplementedError();
  }

  @override
  Future<List<CertificateTypeModel>> getAllCertificateTypes() async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers.addAll({
      'Authorization': "Bearer ${userModel.accessToken}"
    });


    try {
      final response = await dio.get(GET_CERTIFICATE_TYPES);
      if (response.statusCode == 200) {
        List<CertificateTypeModel> list = [];
        for (int i = 0; i < response.data['data'].length; i++) {
          list.add(CertificateTypeModel.fromJson(response.data['data'][i]));
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