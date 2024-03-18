import 'package:dartz/dartz.dart';
import '../repositories/auth_repository.dart';

import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';

class ForgetPasswordUseCase {
  final AuthRepository repository;

  ForgetPasswordUseCase(this.repository);

  Future<Either<Failure, Unit>> call(
      {required String email,
      required String newPassword,
      required String confirmNewPassword,
      required String code,
      required String token
      }) async {
    return await repository.forgetPassword(
        email: email,
        newPassword: newPassword,
        confirmNewPassword: confirmNewPassword,
        code: code, token: token);
  }
}
