import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:learny_project/features/teachers/data/models/techers_model.dart';
import 'package:learny_project/features/teachers/data/models/teachers_requests_model.dart';
import '../../models/teacher_model.dart';
import 'teacher_remote_data_source.dart';
import '../../models/become_a_teacher_model.dart';
import '../../models/teacher_request_details_model.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/strings/api_end_point.dart';
import '../../../../auth/data/datasources/local_data_sources/auth_local_data_sources.dart';
import '../../../../auth/data/datasources/remote_data_sources/helper_function_auth_remote_data_sourcess.dart';
import '../../../../auth/data/models/user_model.dart';

class TeacherRemoteDateSourceImpl implements TeacherRemoteDataSource {
  final AuthLocalDataSources authLocalDataSources;
  late final Dio dio;

  TeacherRemoteDateSourceImpl({required this.authLocalDataSources}) {
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
  Future<Unit> orderBecomeATeacher(
      {required BecomeATeacherModel becomeATeacherModel}) async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers
        .addAll({'Authorization': "Bearer ${userModel.accessToken}"});

    try {
      FormData formData = FormData.fromMap(await becomeATeacherModel.toJson());
      final response = await dio.post(ORDER_BECOME_A_TEACHER, data: formData);
      if (response.statusCode == 201) {
        return Future.value(unit);
      } else {
        throw ServerException();
      }
    } on DioException catch (error) {
      print(error);
      handleDioError(error);
    } catch (error) {
      print(error);
      throw ServerException();
    }
    throw ServerException();
  }

  @override
  Future<TeacherRequestDetailsModel> requestDetails(
      {required int teacherId}) async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers
        .addAll({'Authorization': "Bearer ${userModel.accessToken}"});
    try {
      final response = await dio.get('$TEACHERREQUESTDETAILS$teacherId');
      final requestDetails =
          TeacherRequestDetailsModel.fromJson(response.data['data']);
      return requestDetails;
    } on DioException catch (error) {
      handleDioError(error);
    } catch (error) {
      throw ServerException();
    }
    throw ServerException();
  }

  @override
  Future<List<TeacherRequestsModel>> getAllRequestsTeachers(
      {required List<String> statuses}) async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers
        .addAll({'Authorization': "Bearer ${userModel.accessToken}"});
    String result = statuses.join(",");
    try {
      final data1 = {
        'statuses': result,
      };
      final response = await dio.post(GET_TEACHERS_REQUESTS, data: data1);
      final data = response.data['data'] as List<dynamic>;

      final List<TeacherRequestsModel> teachersRequestsList =
          data.map((item) => TeacherRequestsModel.fromJson(item)).toList();

      return teachersRequestsList;
    } on DioException catch (error) {
      handleDioError(error);
    } catch (error) {
      throw ServerException();
    }
    throw ServerException();
  }

  @override
  Future<TeachersModel> getTeachers(
      {required List<String> languages, required int page}) async {
    try {

      final response = await dio.get(GET_TEACHERS,
          queryParameters: {"languages": languages.join(","), "page": page});
      final TeachersModel teachers =
          TeachersModel.fromJson(response.data);
      return teachers;
    } on DioException catch (error) {
      print(error);
      handleDioError(error);
    } catch (error) {
      print(error);
      throw ServerException();
    }
    throw ServerException();
  }

  @override
  Future<TeacherModel> getTeacher({required int teacherId}) async {

    try {
      final response = await dio.get("$GET_TEACHER$teacherId");
      final TeacherModel teacher = TeacherModel.fromJson(response.data['data']);
      return teacher;
    } on DioException catch (error) {
      handleDioError(error);
    } catch (error) {
      throw ServerException();
    }
    throw ServerException();
  }

  @override
  Future<String> acceptOrRejectRequestTeacher(
      {required String statusId, required String teacherId}) async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers
        .addAll({'Authorization': "Bearer ${userModel.accessToken}"});
    try {
      final data1 = {
        'teacher_id': teacherId,
        'status_id': statusId,
      };
      final response =
          await dio.post(ACCEPT_OR_REGECT_REQUEST_TEACHER, data: data1);
      return response.data['message'];
    } on DioException catch (error) {
      handleDioError(error);
    } catch (error) {
      throw ServerException();
    }
    throw ServerException();
  }
}
