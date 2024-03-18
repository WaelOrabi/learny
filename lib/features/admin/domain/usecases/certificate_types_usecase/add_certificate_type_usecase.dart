import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../repositories/certificate_type_repository.dart';

class AddCertificateTypeUseCase{
  final CertificateTypeRepository repository;
  AddCertificateTypeUseCase(this.repository);
  Future<Either<Failure,Unit>> call({required String certificateTypeName})async{
    return await repository.addCertificateType(certificateTypeName:certificateTypeName );
  }

}