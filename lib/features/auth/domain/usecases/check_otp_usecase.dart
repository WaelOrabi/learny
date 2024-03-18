import 'package:dartz/dartz.dart';
import '../repositories/auth_repository.dart';
import '../../../../core/error/failure.dart';


class CheckOtpUseCase{
  final AuthRepository repository;
  CheckOtpUseCase(this.repository);
  Future<Either<Failure,String>> call({required String email ,required String code})async{
    return await repository.checkOtp(email:email,code: code);
  }

}