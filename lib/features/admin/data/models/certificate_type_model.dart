
import '../../domain/entities/certificate_type_entity.dart';

class CertificateTypeModel extends CertificateType{
  CertificateTypeModel({required super.certificateTypeId, required super.certificateTypeName});
  factory CertificateTypeModel.fromJson(Map<String, dynamic> json) {

    return CertificateTypeModel(
      certificateTypeId: json['id'].toString(),
      certificateTypeName: json['type_name']
     );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': certificateTypeId,
      'type_name': certificateTypeName,
      };
  }

}