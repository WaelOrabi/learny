import '../../domain/entities/donor_type_entity.dart';

class DonorTypeModel extends DonorType{
  DonorTypeModel({required super.donorTypeId, required super.donorTypeName});
  factory DonorTypeModel.fromJson(Map<String, dynamic> json) {
    return DonorTypeModel(
        donorTypeId: json['id'].toString(),
        donorTypeName: json['type_name']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': donorTypeId,
      'type_name': donorTypeName,
    };
  }

}