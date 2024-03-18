import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../datasources/remote_data_sources/country_remote_data_source/country_remote_data_source.dart';
import '../../domain/entities/country_entity.dart';
import '../../domain/repositories/country_repository.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';

class CountryRepositoriesImpl implements CountryRepository{
  final CountryRemoteDataSource countryRemoteDataSource;
  final NetworkInfo networkInfo;

  CountryRepositoriesImpl({required this.countryRemoteDataSource,required this.networkInfo});
  @override
  Future<Either<Failure, Unit>> addCountry({required String countryName}) {
    // TODO: implement addCountry
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> deleteCountry({required String countryId}) {
    // TODO: implement deleteCountry
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Country>>> getAllCountries()  async {
    if (await networkInfo.isConnected) {
      try {
        final  countries=  await countryRemoteDataSource.getAllCountries();
        return  Right(countries);
      } catch (error) {
        if (error is WrongDataException) {
          return Left(WrongDataFailure(messages: error.messages));
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(OffLineFailure());
    }
  }
  
}