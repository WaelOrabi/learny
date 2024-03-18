import 'package:dartz/dartz.dart';
import '../../../../teachers/domain/repositories/teacher_repository.dart';
import '../../../../../core/error/failure.dart';
import '../../repositories/donor_type_repository.dart';

class DeleteDonorTypeUseCase{
  final DonorTypeRepository repository;
  DeleteDonorTypeUseCase(this.repository);
  Future<Either<Failure,Unit>> call({required String donorTypeId})async{
    return await repository.deleteDonorType(donorTypeId:donorTypeId );
  }

}