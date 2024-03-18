import 'package:dartz/dartz.dart';
import '../../entities/country_entity.dart';
import '../../entities/donor_type_entity.dart';
import '../../repositories/donor_type_repository.dart';
import '../../../../teachers/domain/repositories/teacher_repository.dart';
import '../../../../../core/error/failure.dart';
import '../../repositories/country_repository.dart';

class GetAllDonorTypesUseCase{
  final DonorTypeRepository repository;
  GetAllDonorTypesUseCase(this.repository);
  Future<Either<Failure,List<DonorType>>> call()async{
    return await repository.getAllDonorTypes();
  }

}