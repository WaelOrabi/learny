import 'package:equatable/equatable.dart';

class CertificateType extends Equatable{
  String certificateTypeId;
  String certificateTypeName;
  CertificateType({required this.certificateTypeId,required this.certificateTypeName});

  @override
  List<Object?> get props => [certificateTypeId,certificateTypeName];

}