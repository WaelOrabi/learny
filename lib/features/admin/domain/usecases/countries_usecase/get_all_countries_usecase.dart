import 'package:dartz/dartz.dart';
import '../../entities/country_entity.dart';
import '../../../../teachers/domain/repositories/teacher_repository.dart';
import '../../../../../core/error/failure.dart';
import '../../repositories/country_repository.dart';

class GetAllCountriesUseCase{
  final CountryRepository repository;
  GetAllCountriesUseCase(this.repository);
  Future<Either<Failure,List<Country>>> call()async{
    return await repository.getAllCountries();
  }

}