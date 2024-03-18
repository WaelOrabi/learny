part of 'certificate_type_bloc.dart';

@immutable
abstract class CertificateTypeState extends Equatable{
  @override
  List<Object> get props=>[];
}


class CertificateTypeInitial extends CertificateTypeState {}


class GetAllCertificateTypesLoadingState extends CertificateTypeState {}

class GetAllCertificateTypesSuccessState extends CertificateTypeState {
  final List<CertificateType> listAllCertificateTypes;

  GetAllCertificateTypesSuccessState({required this.listAllCertificateTypes});
}

class GetAllCertificateTypesErrorState extends CertificateTypeState {
  final List<String?> message;

  GetAllCertificateTypesErrorState({required this.message});
  @override
  List<Object>get props=>[message];
}



class AddCertificateTypeLoadingState extends CertificateTypeState {}

class AddCertificateTypeSuccessState extends CertificateTypeState {}

class AddCertificateTypeErrorState extends CertificateTypeState {
  final List<String?> message;

  AddCertificateTypeErrorState({required this.message});
  @override
  List<Object>get props=>[message];
}




class DeleteCertificateTypeLoadingState extends CertificateTypeState {}

class DeleteCertificateTypeSuccessState extends CertificateTypeState {}

class DeleteCertificateTypeErrorState extends CertificateTypeState {
  final List<String> message;

  DeleteCertificateTypeErrorState({required this.message});
  @override
  List<Object>get props=>[message];
}
