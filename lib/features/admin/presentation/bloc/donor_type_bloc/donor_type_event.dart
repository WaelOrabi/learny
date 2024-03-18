part of 'donor_type_bloc.dart';

@immutable
abstract class DonorTypeEvent extends Equatable{
  @override
  List<Object> get props=>[];
}


class GetAllDonorTypesEvent extends DonorTypeEvent{}


class AddDonorTypeEvent extends DonorTypeEvent{
  final String donorTypeName;

  AddDonorTypeEvent({required this.donorTypeName});
  @override
  List<Object> get props=>[donorTypeName];

}

class DeleteDonorTypeEvent extends DonorTypeEvent{
  final String donorTypeId;

  DeleteDonorTypeEvent({required this.donorTypeId});
  @override
  List<Object> get props=>[donorTypeId];

}