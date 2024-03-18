import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:learny_project/features/appointment/data/models/get_goals_model.dart';
import 'package:learny_project/features/appointment/data/models/get_student_appointment_model.dart';
import 'package:learny_project/features/appointment/data/models/get_student_appointments_model.dart';
import 'package:learny_project/features/appointment/data/models/get_teacher_appointment_model.dart';
import 'package:learny_project/features/appointment/data/models/get_teacher_appointments_model.dart';
import 'package:learny_project/features/appointment/data/models/update_booking_appointment_model.dart';
import 'package:learny_project/features/auth/data/datasources/local_data_sources/auth_local_data_sources.dart';
import 'package:learny_project/core/error/exception.dart';
import 'package:learny_project/core/strings/api_end_point.dart';
import 'package:learny_project/features/auth/data/models/user_model.dart';
import '../../../auth/data/datasources/remote_data_sources/helper_function_auth_remote_data_sourcess.dart';
import '../models/booking_appointment_model.dart';
import 'appointment_remote_data_source.dart';

class AppointmentRemoteDataSourceImpl extends AppointmentRemoteDataSource {
  late final Dio dio;
  final AuthLocalDataSources authLocalDataSources;

  AppointmentRemoteDataSourceImpl({required this.authLocalDataSources}) {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: BASE_URL,
      receiveDataWhenStatusError: true,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
    );
    dio = Dio(baseOptions);
  }

  @override
  Future<Unit> bookingAppointment(
      {required BookingAppointmentModel bookingAppointmentModel}) async {
    try {
      await _setAuthorizationHeader();
      final Map<String, dynamic> bookingAppointmentJson =
          await bookingAppointmentModel.toJson();
      final response =
          await dio.post(BOOKING_APPOINTMENT, data: bookingAppointmentJson);
      if (response.statusCode == 200) {
        return Future.value(unit);
      }
    } catch (error) {
      _handleError(error);
    }
    return Future.value(unit);
  }

  @override
  Future<GetTeacherAppointmentsModel> getTeacherAppointments(
      {required List<String> status, required int numberPage}) async {
    await _setAuthorizationHeader();
    final response = await dio.get(GET_TEACHER_APPOINTMENTS,
        queryParameters: {"statuses": status.join(","), "page": numberPage});
    try {
      if (response.statusCode == 200) {
        final getTeacherAppointmentsModel =
            GetTeacherAppointmentsModel.fromJson(response.data);
        return getTeacherAppointmentsModel;
      } else {
        throw ServerException();
      }
    } catch (error) {
      _handleError(error);
    }
    throw ServerException();
  }

  @override
  Future<GetTeacherAppointmentModel> getTeacherAppointment(
      {required int idAppointment}) async {
    await _setAuthorizationHeader();
    final response = await dio.get("$GET_TEACHER_APPOINTMENT$idAppointment");
    try {
      if (response.statusCode == 200) {
        final getTeacherAppointmentModel =
            GetTeacherAppointmentModel.fromJson(response.data);
        return getTeacherAppointmentModel;
      } else {
        throw ServerException();
      }
    } catch (error) {
      _handleError(error);
    }
    throw ServerException();
  }

  @override
  Future<GetStudentAppointmentModel> getStudentAppointment(
      {required int idAppointment}) async {
    await _setAuthorizationHeader();
    final response = await dio.get("$GET_STUDENT_APPOINTMENT$idAppointment");
    try {
      if (response.statusCode == 200) {
        final getTeacherAppointmentModel =
            GetStudentAppointmentModel.fromJson(response.data);
        return getTeacherAppointmentModel;
      } else {
        throw ServerException();
      }
    } catch (error) {
      _handleError(error);
    }
    throw ServerException();
  }

  @override
  Future<GetStudentAppointmentsModel> getStudentAppointments(
      {required List<String> status, required int numberPage}) async {
    await _setAuthorizationHeader();
    final response = await dio.get(GET_STUDENT_APPOINTMENTS,
        queryParameters: { "page": numberPage,"statuses": status.join(",")});
    try {
      if (response.statusCode == 200) {
        final getStudentAppointmentsModel =
            GetStudentAppointmentsModel.fromJson(response.data);
        return getStudentAppointmentsModel;
      } else {
        throw ServerException();
      }
    } catch (error) {
      _handleError(error);
    }
    throw ServerException();
  }
  @override
  Future<GoalsModel> getGoals() async{
    await _setAuthorizationHeader();
    final response=await dio.get(GET_GOALS);
    try{
      if(response.statusCode==200)
        {
          final getGoals=GoalsModel.fromJson(response.data);
          return getGoals;
        } else {
        throw ServerException();
      }
    }catch (error) {
      _handleError(error);
    }
    throw ServerException();
  }
  @override
  Future<Unit> updateBookingAppointment(
      {required UpdateBookingAppointmentModel
          updateBookingAppointmentModel}) async {
    try {
      await _setAuthorizationHeader();
      final Map<String, dynamic> updateBookingAppointmentJson =
          await updateBookingAppointmentModel.toJson();
      await dio.put(UPDATE_APPOINTMENT, data: updateBookingAppointmentJson);
    } catch (error) {
      _handleError(error);
    }
    return Future.value(unit);
  }
  @override
  Future<Unit> deleteAppointment({required String idAppointment}) async {
    try {
      await _setAuthorizationHeader();
      await dio.get("$DELETE_APPOINTMENT$idAppointment");
    } catch (error) {
      _handleError(error);
    }
    return Future.value(unit);
  }
  @override
  Future<Unit> changeStateAppointment({required int appointmentId, required int statusId}) async{
    try{
      await _setAuthorizationHeader();
      await dio.post(CHANGE_STATE_APPOINTMENT,data: {
        'status_id':statusId,
        'appointment_id':appointmentId,
      });
      return Future.value(unit);
    }catch (error){
      _handleError(error);
    }
    return Future.value(unit);
  }
  void _handleError(error) {
    if (error is DioException) {
      handleDioError(error);
    } else {
      throw ServerException();
    }
  }


  Future<void> _setAuthorizationHeader() async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers.addAll({
      'Authorization': "Bearer ${userModel.accessToken}"
    });
  }






}
