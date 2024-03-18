import 'package:dartz/dartz.dart';
import '../repositories/auth_repository.dart';
import '../../../../core/error/failure.dart';

class ChangePasswordUseCase {
  final AuthRepository repository;

  ChangePasswordUseCase(this.repository);

  Future<Either<Failure, Unit>> call(
      {required String oldPassword,
      required String newPassword,
      required String confirmNewPassword}) async {
    return await repository.changePassword(oldPassword: oldPassword, newPassword: newPassword, confirmNewPassword: confirmNewPassword);
  }
}
