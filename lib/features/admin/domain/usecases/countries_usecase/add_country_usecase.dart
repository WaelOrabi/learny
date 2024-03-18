import 'package:dartz/dartz.dart';
import '../../repositories/admin_repository.dart';
import '../../repositories/country_repository.dart';
import '../../../../teachers/domain/repositories/teacher_repository.dart';
import '../../../../../core/error/failure.dart';

class AddCountryUseCase{
  final CountryRepository repository;
  AddCountryUseCase(this.repository);
  Future<Either<Failure,Unit>> call({required String countryName})async{
    return await repository.addCountry(countryName:countryName );
  }

}