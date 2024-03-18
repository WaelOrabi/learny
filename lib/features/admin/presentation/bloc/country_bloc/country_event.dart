part of 'country_bloc.dart';

@immutable
abstract class CountryEvent extends Equatable{
  @override
  List<Object> get props=>[];
}


class GetAllCountriesEvent extends CountryEvent{}


class AddCountryEvent extends CountryEvent{
  final String countryName;

  AddCountryEvent({required this.countryName});
  @override
  List<Object> get props=>[countryName];

}

class DeleteCountryEvent extends CountryEvent{
  final String countryId;

  DeleteCountryEvent({required this.countryId});
  @override
  List<Object> get props=>[countryId];

}