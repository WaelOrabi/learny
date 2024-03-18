import 'package:dartz/dartz.dart';
import '../repositories/auth_repository.dart';
import '../../../../core/error/failure.dart';

class LogOutUseCase{
  final AuthRepository repository;
  LogOutUseCase(this.repository);
  Future<Either<Failure,Unit>> call()async{
    return await repository.logOut();
  }

}