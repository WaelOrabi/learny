
import 'package:dartz/dartz.dart';

import '../../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<Unit> signUp({required UserModel userModel});

  Future<UserModel> login({required String email, required String password});
  Future<UserModel> verifyAccount({required String email, required String code});
  Future<Unit> sendOtp({required String email});
  Future<String> checkOtp({required String email, required String code});

  Future<Unit> signupWithGoogle();

  Future<Unit> loginWithGoogle();

  Future<Unit> logOut();

  Future<Unit> forgetPassword( {required String email,
    required String code,
    required String newPassword,
    required String confirmNewPassword,
    required String token,

  });

  Future<Unit> changePassword(
      {required String oldPassword,
      required String newPassword,
      required String confirmNewPassword});

  Future<Unit> deleteAccount({required UserModel userModel});
}