part of 'certificate_type_bloc.dart';

@immutable
abstract class CertificateTypeEvent extends Equatable{
  @override
  List<Object> get props=>[];
}


class GetAllCertificateTypesEvent extends CertificateTypeEvent{}


class AddCertificateTypeEvent extends CertificateTypeEvent{
  final String certificateTypeName;

  AddCertificateTypeEvent({required this.certificateTypeName});
  @override
  List<Object> get props=>[certificateTypeName];

}

class DeleteCertificateTypeEvent extends CertificateTypeEvent{
  final String certificateTypeId;

  DeleteCertificateTypeEvent({required this.certificateTypeId});
  @override
  List<Object> get props=>[certificateTypeId];

}