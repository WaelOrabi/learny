import 'package:dartz/dartz.dart';
import '../../../models/certificate_type_model.dart';

abstract class CertificateTypeRemoteDataSource{
Future<List<CertificateTypeModel>>getAllCertificateTypes();
Future<Unit> addCertificateType({required String certificateTypeName});
Future<Unit> deleteCertificateType({required String certificateTypeId});
}