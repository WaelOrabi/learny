import 'package:dartz/dartz.dart';
import '../../entities/certificate_type_entity.dart';
import '../../entities/country_entity.dart';
import '../../../../../core/error/failure.dart';
import '../../repositories/certificate_type_repository.dart';

class GetAllCertificateTypesUseCase{
  final CertificateTypeRepository repository;
  GetAllCertificateTypesUseCase(this.repository);
  Future<Either<Failure,List<CertificateType>>> call()async{
    return await repository.getAllCertificateTypes();
  }

}