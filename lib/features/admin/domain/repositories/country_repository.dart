import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/country_entity.dart';

abstract class CountryRepository {
  Future<Either<Failure,List<Country>>> getAllCountries();
  Future<Either<Failure,Unit>> addCountry({required String countryName});
  Future<Either<Failure,Unit>> deleteCountry({required String countryId});
}
