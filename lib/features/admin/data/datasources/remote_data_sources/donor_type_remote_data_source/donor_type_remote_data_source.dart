import 'package:dartz/dartz.dart';
import '../../../models/donor_type_model.dart';

abstract class DonorTypeRemoteDataSource{
  Future<List<DonorTypeModel>>getAllDonorTypes();
  Future<Unit> addDonorType({required String donorTypeName});
  Future<Unit> deleteDonorType({required String donorTypeId});
}