import 'package:equatable/equatable.dart';

class DonorType extends Equatable{
  String donorTypeId;
  String donorTypeName;
  DonorType({required this.donorTypeId,required this.donorTypeName});

  @override
  List<Object?> get props => [donorTypeId,donorTypeName];

}