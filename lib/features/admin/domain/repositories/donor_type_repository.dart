import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/donor_type_entity.dart';

abstract class DonorTypeRepository {
  Future<Either<Failure,List<DonorType>>> getAllDonorTypes();
  Future<Either<Failure,Unit>> addDonorType({required String donorTypeName});
  Future<Either<Failure,Unit>> deleteDonorType({required String donorTypeId});
}
