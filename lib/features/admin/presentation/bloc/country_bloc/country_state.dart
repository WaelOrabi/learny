part of 'country_bloc.dart';

@immutable
abstract class CountryState  extends Equatable{
  @override
  List<Object> get props=>[];
}


class CountryInitial extends CountryState {}


class GetAllCountriesLoadingState extends CountryState {}

class GetAllCountriesSuccessState extends CountryState {
  final List<Country> listAllCountries;

  GetAllCountriesSuccessState({required this.listAllCountries});
}

class GetAllCountriesErrorState extends CountryState {
  final List<String?> message;

  GetAllCountriesErrorState({required this.message});
  @override
  List<Object>get props=>[message];
}


class AddCountryLoadingState extends CountryState {}

class AddCountrySuccessState extends CountryState {}

class AddCountryErrorState extends CountryState {
  final List<String?> message;

  AddCountryErrorState({required this.message});
  @override
  List<Object>get props=>[message];
}




class DeleteCountryLoadingState extends CountryState {}

class DeleteCountrySuccessState extends CountryState {}

class DeleteCountryErrorState extends CountryState {
  final List<String> message;

  DeleteCountryErrorState({required this.message});
  @override
  List<Object>get props=>[message];
}
