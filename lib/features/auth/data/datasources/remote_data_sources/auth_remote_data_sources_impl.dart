import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/error/exception.dart';
import '../local_data_sources/auth_local_data_sources.dart';
import '../../../../../core/strings/api_end_point.dart';
import '../../models/user_model.dart';
import 'auth_remote_data_sources.dart';
import 'helper_function_auth_remote_data_sourcess.dart';

class AuthRemoteDataSourcesImpl implements AuthRemoteDataSource {
  final AuthLocalDataSources authLocalDataSources;
  late final Dio dio;

  AuthRemoteDataSourcesImpl({required this.authLocalDataSources}) {
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
  Future<Unit> changePassword(
      {required String oldPassword,
      required String newPassword,
      required String confirmNewPassword}) async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers.addAll({
      'Authorization': "Bearer ${userModel.accessToken}",
    });
    final data = {
      'old_password': oldPassword,
      'password': newPassword,
      'password_confirmation': confirmNewPassword,

    };

  return   funHelper(endPoint: CHANGE_PASSWORD, data: data, dio: dio);

  }

  @override
  Future<Unit> deleteAccount({required UserModel userModel}) {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }

  @override
  Future<Unit> logOut() async {
    UserModel userModel = await authLocalDataSources.getCachedUser();
    dio.options.headers.addAll({
      'Authorization': "Bearer ${userModel.accessToken}"

    });
    try {
       await dio.post(LOGOUT_API);
      return Future.value(unit);
    } catch (e) {
      throw WrongDataException(messages: [e.toString()]);
    }
  }

  @override
  Future<UserModel> login(
      {required String email, required String password}) async {
    final data = {'email': email, 'password': password};
    return requestLogin(dio: dio, endPoint: LOGIN_API, requestData: data);
  }

  @override
  Future<Unit> loginWithGoogle() {
    // TODO: implement loginWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<Unit> signUp({required UserModel userModel}) async {

    try {
      final data=userModel.toJson();
      final response = await dio.post(REGISTER_API,data: data);// data);
      if (response.statusCode == 201) {
        return Future.value(unit);
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

  @override
  Future<Unit> signupWithGoogle() {
    // TODO: implement signupWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<UserModel> verifyAccount(
      {required String email, required String code}) {
    final data = {'email': email, 'code': code};
    return requestLogin(dio: dio, endPoint: VERIFY_ACCOUNT, requestData: data);
  }

  @override
  Future<String> checkOtp({required String email, required String code}) async {
    final data = {'email': email, 'code': code};
    try{
      final response = await dio.post(CHECK_OTP, data: data);
      if(response.statusCode==200 ){
        String token= response.data['data']['token'];
        return Future.value(token);
      }
      else {
        throw ServerException();
      }
    } on DioException catch (error) {
      handleDioError(error);
    } catch (error) {
      throw ServerException();
    }
    throw ServerException();


  }

  @override
  Future<Unit> sendOtp({required String email}) async {
    final data = {'email': email};
    return funHelper(endPoint: SEND_OTP, data: data, dio: dio);

  }

  @override
  Future<Unit> forgetPassword(
      {required String email,
      required String code,
      required String newPassword,
      required String confirmNewPassword,
      required String token,
      }) async {
    final data = {
      'email': email,
      'code': code,
      'password': newPassword,
      'password_confirmation': confirmNewPassword,
      'token': token,
    };
   return funHelper(endPoint: FORGET_PASSWORD, data: data, dio: dio);

  }
}
