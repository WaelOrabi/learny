import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/local_data_sources/auth_local_data_sources.dart';
import '../datasources/remote_data_sources/auth_remote_data_sources.dart';
import '../models/user_model.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoriesImpl implements AuthRepository {
  final AuthLocalDataSources localDataSources;
  final AuthRemoteDataSource authRemoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoriesImpl({
    required this.authRemoteDataSource,
    required this.networkInfo,
    required this.localDataSources,
  });

  @override
  Future<Either<Failure, Unit>> changePassword(
      {required String oldPassword,
      required String newPassword,
      required String confirmNewPassword}) async {
    if (await networkInfo.isConnected) {
      try {
        await authRemoteDataSource.changePassword(
            oldPassword: oldPassword,
            newPassword: newPassword,
            confirmNewPassword: confirmNewPassword);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAccount({required UserModel user}) {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> logOut() async {
    if (await networkInfo.isConnected) {
      try {
        await authRemoteDataSource.logOut();
        localDataSources.deleteCachedUser();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login(
      {required String email, required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        final UserModel remoteDataSource =
            await authRemoteDataSource.login(email: email, password: password);
        localDataSources.cachedUser(userModel: remoteDataSource);

        return Right(remoteDataSource);
      }
      catch (error) {
        if (error is WrongDataException) {
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> loginWithGoogle() {
    // TODO: implement loginWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> signup({required UserModel user}) async {

    if (await networkInfo.isConnected) {
      try {

            await authRemoteDataSource.signUp(userModel: user);

        return const Right(unit);
      } catch (error) {
        if (error is WrongDataException) {
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signupWithGoogle() {
    // TODO: implement signupWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> verifyAccount(
      {required String email, required String code}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteDataSource =
            await authRemoteDataSource.verifyAccount(email: email, code: code);
        localDataSources.cachedUser(userModel: remoteDataSource);
        return Right(remoteDataSource);
      } catch (error) {
        if (error is WrongDataException) {
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, String >> checkOtp(
      {required String email, required String code}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteDataSource =
            await authRemoteDataSource.checkOtp(email: email, code: code);

        return  Right(remoteDataSource);
      } catch (error) {
        if (error is WrongDataException) {
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> sendOtp({required String email}) async {
    if (await networkInfo.isConnected) {
      try {

            await authRemoteDataSource.sendOtp(email: email);
        return const Right(unit);
      } catch (error) {
        if (error is WrongDataException) {
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> forgetPassword(
      {required String email,
      required String newPassword,
      required String confirmNewPassword,
      required String code,
      required String token,

      }) async {
    if (await networkInfo.isConnected) {
      try {
          await authRemoteDataSource.forgetPassword(
            email: email,
            code: code,
            newPassword: newPassword,
            confirmNewPassword: confirmNewPassword,
        token: token
        );
        return const Right(unit);
      } catch (error) {
        if (error is WrongDataException) {
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
