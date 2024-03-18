import 'package:dartz/dartz.dart';
import '../../data/models/user_model.dart';
import '../repositories/auth_repository.dart';

import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';

class LoginUseCase{
  final AuthRepository repository;

  LoginUseCase(this.repository);
  Future<Either<Failure,UserEntity>> call({required String email ,required String password})async{
    return await repository.login(email:email,password: password);
  }

}