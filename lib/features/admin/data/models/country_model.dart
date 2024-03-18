import '../../domain/entities/country_entity.dart';

class CountryModel extends Country{
  CountryModel({required super.countryId, required super.countryName});
  factory CountryModel.fromJson(Map<String, dynamic> json) {

    return CountryModel(
        countryId: json['country_id'].toString(),
        countryName: json['country_name']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country_id': countryId,
      'country_name': countryName,
    };
  }

}