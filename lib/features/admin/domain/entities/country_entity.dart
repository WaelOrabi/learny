import 'package:equatable/equatable.dart';

class Country extends Equatable{
  String countryId;
  String countryName;
  Country({required this.countryId,required this.countryName});

  @override
  List<Object?> get props => [countryId,countryName];

}