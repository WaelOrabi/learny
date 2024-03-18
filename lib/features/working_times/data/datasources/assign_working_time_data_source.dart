import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/strings/api_end_point.dart';
import '../models/working_times_model.dart';


import '../../../../core/error/exception.dart';
import '../../../auth/data/datasources/local_data_sources/auth_local_data_sources.dart';
import '../../../auth/data/datasources/remote_data_sources/helper_function_auth_remote_data_sourcess.dart';
import '../../../auth/data/models/user_model.dart';

abstract class AssignWorkingTimeRemoteDataSource{
  Future<Unit> assignWorkingTimeRemoteDataSource({required AssignWorkingTimeModel assignWorkingTimeModel});
}
class AssignWorkingTimeRemoteDataSourceImpl extends AssignWorkingTimeRemoteDataSource{
  final AuthLocalDataSources authLocalDataSources;
 late final Dio dio;
 AssignWorkingTimeRemoteDataSourceImpl({required this.authLocalDataSources}){
   BaseOptions baseOptions=BaseOptions(
       baseUrl: BASE_URL,
       receiveDataWhenStatusError:  true,
       headers: {
         'Content-Type':'application/json',
         'Accept':'application/json'
       }
   );
   dio=Dio(baseOptions);
 }
  @override
  Future<Unit> assignWorkingTimeRemoteDataSource({required AssignWorkingTimeModel assignWorkingTimeModel}) async{
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers.addAll({
      'Authorization': "Bearer ${userModel.accessToken}"
    });
    Map<String, dynamic> assignWorkingTimeJson=assignWorkingTimeModel.toJson() ;
    try{
      await dio.post('$ASSIGNWORKINGTIME',data: assignWorkingTimeJson);
      return Future.value(unit);
    } on DioException catch (error) {
 handleDioError(error);
 }
 throw ServerException();
}

}
