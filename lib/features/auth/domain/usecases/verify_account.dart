import 'package:dartz/dartz.dart';
import '../../data/models/user_model.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

import '../../../../core/error/failure.dart';


class VerifyAccountUseCase{
  final AuthRepository repository;
  VerifyAccountUseCase(this.repository);
  Future<Either<Failure, UserEntity>> call({required String email,required String code}){
    return repository.verifyAccount(email: email,code: code);
  }
}