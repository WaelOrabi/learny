import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../datasources/remote_data_sources/donor_type_remote_data_source/donor_type_remote_data_source.dart';
import '../../domain/entities/donor_type_entity.dart';
import '../../domain/repositories/donor_type_repository.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';

class DonorTypeRepositoriesImpl implements DonorTypeRepository{
  final DonorTypeRemoteDataSource donorTypeRemoteDataSource;
  final NetworkInfo networkInfo;

  DonorTypeRepositoriesImpl({required this.donorTypeRemoteDataSource,required this.networkInfo});
  @override
  Future<Either<Failure, Unit>> addDonorType({required String donorTypeName}) {
    // TODO: implement addDonorType
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> deleteDonorType({required String donorTypeId}) {
    // TODO: implement deleteDonorType
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<DonorType>>> getAllDonorTypes() async {
    if (await networkInfo.isConnected) {
      try {
        final  donorTypes=  await donorTypeRemoteDataSource.getAllDonorTypes();
        return  Right(donorTypes);
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