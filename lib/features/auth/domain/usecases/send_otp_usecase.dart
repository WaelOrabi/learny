import 'package:dartz/dartz.dart';
import '../repositories/auth_repository.dart';

import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';

class SendOtpUseCase{
  final AuthRepository repository;

  SendOtpUseCase(this.repository);
  Future<Either<Failure,Unit>> call({required String email })async{
    return await repository.sendOtp(email:email);
  }

}