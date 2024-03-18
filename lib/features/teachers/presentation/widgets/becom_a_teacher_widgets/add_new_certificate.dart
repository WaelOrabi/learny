import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../domain/entities/certificate.dart';
import '../../bloc/become_a_teacher/become_a_teacher_bloc.dart';

import '../../../../admin/domain/entities/certificate_type_entity.dart';
import '../../../../admin/domain/entities/country_entity.dart';
import '../../../../admin/domain/entities/donor_type_entity.dart';
import '../../../domain/entities/donor_certificate.dart';
import 'certificate.dart';

Widget addNewCertificate(int index) {
  return Tooltip(
    message: "add  more certificate ",
    child: BlocBuilder<BecomeATeacherBloc, BecomeATeacherState>(
      builder: (context, state) {
        return IconButton(
          icon: const Icon(
            Icons.add,
            color: Colors.black87,
          ),
          splashRadius: 2.w,
          onPressed: () {
            BlocProvider.of<BecomeATeacherBloc>(context).add(
                NewCertificateEvent(
                    certificateScreen: CertificateScreen(
                        certificate: Certificate(
                            certificateType: CertificateType(
                                certificateTypeId: "1",
                                certificateTypeName: "Master's"),
                            dateCertificate: "",
                            donorCertificate: DonorCertificate(
                                donorType: DonorType(
                                    donorTypeId: "1",
                                    donorTypeName: "Academic education"),
                                donorName: TextEditingController(),
                                donorCountry: Country(
                                    countryId: "209",
                                    countryName: "Syrian Arab Republic")),
                            imageCertificate: XFile(""), imagesOfCertificate: ''),
                        indexCertificate: 0,
                        indexTeachingLanguage: index,
                        visibleDelete: false),
                    indexTeachingLanguage: index));
            // NewCertificateEvent(certificateScreen: BlocProvider.of<BecomeATeacherBloc>(context).listTeachingLanguagesScreens[index].teachingLanguages.listCertificateScreen[0], indexTeachingLanguage: index));
          },
        );
      },
    ),
  );
}
