import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../data/models/user_model.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> signup({required UserModel user});

  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, Unit>> signupWithGoogle();

  Future<Either<Failure, Unit>> loginWithGoogle();

  Future<Either<Failure, Unit>> logOut();

  Future<Either<Failure, UserEntity>> verifyAccount(
      {required String email, required String code});

  Future<Either<Failure, Unit>> forgetPassword(
      {required String email,
      required String newPassword,
      required String confirmNewPassword,
      required String code,
      required String token
      });

  Future<Either<Failure, Unit>> changePassword(
      {required String oldPassword,
      required String newPassword,
      required String confirmNewPassword});

  Future<Either<Failure, Unit>> deleteAccount({required UserModel user});

  Future<Either<Failure, Unit>> sendOtp({required String email});

  Future<Either<Failure, String>> checkOtp(
      {required String email, required String code});
}
