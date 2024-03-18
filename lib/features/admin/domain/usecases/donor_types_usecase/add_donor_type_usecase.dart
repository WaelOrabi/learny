import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../repositories/donor_type_repository.dart';

class AddDonorTypeUseCase{
  final DonorTypeRepository repository;
  AddDonorTypeUseCase(this.repository);
  Future<Either<Failure,Unit>> call({required String donorTypeName})async{
    return await repository.addDonorType(donorTypeName:donorTypeName );
  }

}