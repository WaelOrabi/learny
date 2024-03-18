import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../admin/domain/entities/level_entity.dart';
import '../../../../admin/presentation/bloc/language_bloc/language_bloc.dart';
import '../../../../admin/presentation/bloc/level_bloc/level_bloc.dart';
import '../../../domain/entities/teaching_languages.dart';
import '../../bloc/become_a_teacher/become_a_teacher_bloc.dart';
import 'teaching_languages_screen.dart';
import '../../../../admin/domain/entities/language_entity.dart';
import '../../../../admin/presentation/bloc/certificate_type_bloc/certificate_type_bloc.dart';
import '../../../../admin/presentation/bloc/country_bloc/country_bloc.dart';
import '../../../../admin/presentation/bloc/donor_type_bloc/donor_type_bloc.dart';
import '../../../domain/entities/certificate.dart';
import '../../../domain/entities/donor_certificate.dart';
import 'certificate.dart';

Widget addNewLanguages({required List<Language> listLanguages,required List<Level> listLevels}) {
  return Tooltip(
    message: "add more languages",
    child: BlocBuilder<BecomeATeacherBloc, BecomeATeacherState>(
      builder: (context, state) {
        return IconButton(
          icon: const Icon(Icons.add),
          splashRadius: 1.w,
          onPressed: () {

            BlocProvider.of<BecomeATeacherBloc>(context).add(NewTeachingLanguagesEvent(teachingLanguagesScreen: TeachingLanguagesScreen(
                teachingLanguages: TeachingLanguages(
                    language: BlocProvider.of<LanguageBloc>(context).listLanguages[0],
                    level: BlocProvider.of<LevelBloc>(context).listLevels[0],
                    yearOfExperience: TextEditingController(),
                    listCertificateScreen: [
                      CertificateScreen(
                          certificate: Certificate(
                              certificateType:BlocProvider.of<CertificateTypeBloc>(context).listCertificateType[0],
                              dateCertificate: "",
                              donorCertificate: DonorCertificate(
                                  donorType:BlocProvider.of<DonorTypeBloc>(context).listDonorType[0],
                                  donorName:
                                  TextEditingController(),
                                  donorCountry:BlocProvider.of<CountryBloc>(context).listCountries[0]),
                              imageCertificate: XFile(""), imagesOfCertificate: ''),
                          indexCertificate: 0,
                          indexTeachingLanguage: 0,
                          visibleDelete: false)
                    ]),
                indexTeachingLanguage: 0,
                deleteVisibility: false, listLanguages: listLanguages,listLevels: listLevels,)));
            },
        );
      },
    ),
  );
}

