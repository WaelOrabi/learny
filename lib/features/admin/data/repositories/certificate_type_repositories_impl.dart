import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../datasources/remote_data_sources/certificate_type_remote_data_source/certificate_type_remote_data_source.dart';
import '../../domain/entities/certificate_type_entity.dart';
import '../../domain/repositories/certificate_type_repository.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';

class CertificateTypeRepositoriesImpl implements CertificateTypeRepository{
  final CertificateTypeRemoteDataSource certificateTypeRemoteDataSource;
  final NetworkInfo networkInfo;

  CertificateTypeRepositoriesImpl(
      {required this.certificateTypeRemoteDataSource,required this.networkInfo});
  @override
  Future<Either<Failure, Unit>> addCertificateType({required String certificateTypeName}) {
    // TODO: implement addCertificateType
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> deleteCertificateType({required String certificateTypeId}) {
    // TODO: implement deleteCertificateType
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<CertificateType>>> getAllCertificateTypes() async {
    if (await networkInfo.isConnected) {
      try {
  final  certificateTypes=  await certificateTypeRemoteDataSource.getAllCertificateTypes();
        return  Right(certificateTypes);
      } catch (error) {
        if (error is WrongDataException) {
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }
  
}