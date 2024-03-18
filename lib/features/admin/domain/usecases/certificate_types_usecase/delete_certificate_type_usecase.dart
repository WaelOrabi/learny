import 'package:dartz/dartz.dart';
import '../../../../teachers/domain/repositories/teacher_repository.dart';
import '../../../../../core/error/failure.dart';
import '../../repositories/certificate_type_repository.dart';
class DeleteCertificateTypeUseCase{
  final CertificateTypeRepository repository;
  DeleteCertificateTypeUseCase(this.repository);
  Future<Either<Failure,Unit>> call({required String certificateTypeId})async{
    return await repository.deleteCertificateType(certificateTypeId:certificateTypeId );
  }

}