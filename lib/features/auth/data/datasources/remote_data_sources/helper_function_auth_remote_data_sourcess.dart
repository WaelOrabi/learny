import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/network_info.dart';
import '../../models/error_respons.dart';
import '../../models/user_model.dart';

 void handleDioError(DioException error) {
  if (error.response?.statusCode == 400 ||
      error.response?.statusCode == 422 ||
      error.response?.statusCode == 403 ||
      error.response?.statusCode == 401) {
    print(error);
    final errorResponse = ErrorResponse.fromJson(error.response?.data);
    throw WrongDataException(
        messages: errorResponse.errors ?? [errorResponse.message]);
  } else if (error.response?.statusCode == 500) {
    print(error.response);
    final errorResponse = ErrorResponse.fromJson(error.response?.data);
    throw WrongDataException(
        messages: errorResponse.errors!.isEmpty
            ? ["The entry data is wrong replay with right answer."]
            : errorResponse.errors!);
  } else {
    throw ServerException();
  }
}

Future<UserModel> requestLogin(
    {required Dio dio,required String endPoint,required Map<String, dynamic> requestData}) async {
  try {
    final response = await dio.post(endPoint, data: requestData);
    if (response.statusCode == 201 || response.statusCode == 200) {
      final userData = UserModel.fromJson(response.data['data']);
      return userData;
    }
  } on DioException catch (error) {
    handleDioError(error);
  } catch (error) {
    throw ServerException();
  }
  throw ServerException();
}

Future<Unit> funHelper(
    {required String endPoint, required final data, required Dio dio}) async {
  try {
    final response = await dio.post(endPoint, data: data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  } on DioException catch (error) {
    handleDioError(error);
  }

  throw ServerException();
}
