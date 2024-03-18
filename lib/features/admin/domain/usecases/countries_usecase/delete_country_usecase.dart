import 'package:dartz/dartz.dart';
import '../../../../teachers/domain/repositories/teacher_repository.dart';
import '../../../../../core/error/failure.dart';
import '../../repositories/country_repository.dart';

class DeleteCountryUseCase{
  final CountryRepository repository;
  DeleteCountryUseCase(this.repository);
  Future<Either<Failure,Unit>> call({required String countryId})async{
    return await repository.deleteCountry(countryId:countryId );
  }

}