

import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import '../../../admin/domain/entities/certificate_type_entity.dart';
import 'donor_certificate.dart';


class Certificate extends Equatable {
  CertificateType certificateType;
  String dateCertificate;
  DonorCertificate donorCertificate;
  XFile imageCertificate;
  String imagesOfCertificate;

  Certificate(
      {required this.certificateType,
      required this.dateCertificate,
      required this.donorCertificate,
      required this.imageCertificate,
      required this.imagesOfCertificate});

  @override
  List<Object?> get props => [
        certificateType,
        dateCertificate,
        donorCertificate,
        imageCertificate,
        imagesOfCertificate
      ];
}
