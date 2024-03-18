import 'package:dartz/dartz.dart';
import '../../../models/country_model.dart';

abstract class CountryRemoteDataSource{
  Future<List<CountryModel>>getAllCountries();
  Future<Unit> addCountry({required String countryName});
  Future<Unit> deleteCountry({required String countryId});
}