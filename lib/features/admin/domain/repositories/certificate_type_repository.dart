import 'package:dartz/dartz.dart';
import '../entities/certificate_type_entity.dart';

import '../../../../core/error/failure.dart';
import '../entities/country_entity.dart';

abstract class CertificateTypeRepository {
  Future<Either<Failure,List<CertificateType>>> getAllCertificateTypes();
  Future<Either<Failure,Unit>> addCertificateType({required String certificateTypeName});
  Future<Either<Failure,Unit>> deleteCertificateType({required String certificateTypeId});
}
