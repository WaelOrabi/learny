part of 'donor_type_bloc.dart';

@immutable
abstract class DonorTypeState extends Equatable{
  @override
  List<Object> get props=>[];
}


class DonorTypeInitial extends DonorTypeState {}


class GetAllDonorTypesLoadingState extends DonorTypeState {}

class GetAllDonorTypesSuccessState extends DonorTypeState {
  final List<DonorType> listAllDonorTypes;

  GetAllDonorTypesSuccessState({required this.listAllDonorTypes});
}

class GetAllDonorTypesErrorState extends DonorTypeState {
  final List<String> message;

  GetAllDonorTypesErrorState({required this.message});
  @override
  List<Object>get props=>[message];
}



class AddDonorTypeLoadingState extends DonorTypeState {}

class AddDonorTypeSuccessState extends DonorTypeState {}

class AddDonorTypeErrorState extends DonorTypeState {
  final List<String> message;

  AddDonorTypeErrorState({required this.message});
  @override
  List<Object>get props=>[message];
}




class DeleteDonorTypeLoadingState extends DonorTypeState {}

class DeleteDonorTypeSuccessState extends DonorTypeState {}

class DeleteDonorTypeErrorState extends DonorTypeState {
  final List<String> message;

  DeleteDonorTypeErrorState({required this.message});
  @override
  List<Object>get props=>[message];
}
