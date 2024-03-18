import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../admin/domain/entities/country_entity.dart';
import '../../../admin/domain/entities/donor_type_entity.dart';

class DonorCertificate extends Equatable{
  DonorType donorType;
  TextEditingController donorName;
  Country donorCountry;
 DonorCertificate({
    required this.donorType,
   required this.donorName,
   required this.donorCountry
});
  @override
  List<Object?> get props => [donorType,donorName,donorCountry];
}