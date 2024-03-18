import 'package:dartz/dartz.dart';
import '../../data/models/user_model.dart';
import '../repositories/auth_repository.dart';

import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';

class SignUpUseCase{
  final AuthRepository repository;

  SignUpUseCase(this.repository);
  Future<Either<Failure, Unit>> call({required UserModel user}){
    return repository.signup(user: user);
  }
}