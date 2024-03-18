import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learny_project/features/home/presentation/pages/home_page.dart';
import '../../../../../core/widgets/toast_widget.dart';
import '../../../domain/entities/become_a_teacher_entity.dart';
import '../../bloc/become_a_teacher/become_a_teacher_bloc.dart';

import '../../../../auth/presentation/widgets/ElvatedButtonWdget.dart';

class AgreeAndSubmit extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final GlobalKey<FormState> personalKey;

  const AgreeAndSubmit(
      {Key? key, required this.formKey, required this.personalKey})
      : super(key: key);

  @override
  State<AgreeAndSubmit> createState() => _AgreeAndSubmitState();
}

class _AgreeAndSubmitState extends State<AgreeAndSubmit> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<BecomeATeacherBloc, BecomeATeacherState>(
                builder: (context, state) {
                  return IconButton(
                      splashRadius: 1.w,
                      onPressed: () {
                        BlocProvider.of<BecomeATeacherBloc>(context)
                            .add(AgreeEvent());
                      },
                      icon: BlocProvider.of<BecomeATeacherBloc>(context)
                                  .isAgree ==
                              false
                          ? const Icon(Icons.radio_button_off_outlined)
                          : const Icon(
                              Icons.radio_button_checked_outlined,
                              color: Colors.blue,
                            ));
                },
              ),
              Text(
                "Agree to the terms of the",
                style: TextStyle(fontSize: 23.sp),
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "privacy policy.",
                    style: TextStyle(color: Color(0xff30C7EC), fontSize: 23.sp),
                  ))
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Center(
          child: MyElevatedButton(
            width: 200.w,
            height: 60.h,
            onPressed: () {
              if (BlocProvider.of<BecomeATeacherBloc>(context).isAgree ==
                  false) {
                showToastWidgetError("You must agree to the terms first.");
              } else if (BlocProvider.of<BecomeATeacherBloc>(context)
                          .listImageCard[0] ==
                      null ||
                  BlocProvider.of<BecomeATeacherBloc>(context)
                          .listImageCard[1] ==
                      null) {
                showToastWidgetError("You must enter your images card.");
              } else if (widget.formKey.currentState!.validate()) {
                LanguageBecomeATeacher lang = LanguageBecomeATeacher(
                    languageId: '',
                    languageLevelId: '',
                    yearsOfExperience: '',
                    certificates: []);
                List<LanguageBecomeATeacher> listLanguageBecomeATeacher = [];

                var listTeachingLanguagesScreens =
                    BlocProvider.of<BecomeATeacherBloc>(context)
                        .listTeachingLanguagesScreens;

                bool v1 = false;
                bool result = true;
                for (int i = 0; i < listTeachingLanguagesScreens.length; i++) {
                  listTeachingLanguagesScreens[i]
                      .teachingLanguages
                      .listCertificateScreen
                      .map((e) {
                    if (e.certificate.imagesOfCertificate.isEmpty) {
                      result = true && v1;
                    }
                  }).toList();
                }
                if (result) {
                  for (int i = 0;
                      i < listTeachingLanguagesScreens.length;
                      i++) {
                    lang.languageId = listTeachingLanguagesScreens[i]
                        .teachingLanguages
                        .language
                        .languageId;
                    lang.languageLevelId = listTeachingLanguagesScreens[i]
                        .teachingLanguages
                        .level
                        .levelId;
                    lang.yearsOfExperience = listTeachingLanguagesScreens[i]
                        .teachingLanguages
                        .yearOfExperience
                        .text;

                    listTeachingLanguagesScreens[i]
                        .teachingLanguages
                        .listCertificateScreen
                        .map((e) {
                      lang.certificates.add(CertificateBecomeATeacher(
                          certificateImage: e.certificate.imagesOfCertificate,
                          certificateDate: e.certificate.dateCertificate,
                          certificateTypeId:
                              e.certificate.certificateType.certificateTypeId,
                          donor: DonorBecomeATeacher(
                              donorTypeId: e.certificate.donorCertificate
                                  .donorType.donorTypeId,
                              donorName:
                                  e.certificate.donorCertificate.donorName.text,
                              countryId: e.certificate.donorCertificate
                                  .donorCountry.countryId)));
                    }).toList();
                    listLanguageBecomeATeacher.add(lang);
                  }
                  BecomeATeacherEntity becomeATeacherEntity = BecomeATeacherEntity(
                      infoBecomeATeacher: InfoBecomeATeacher(
                          firstName: BlocProvider.of<BecomeATeacherBloc>(context)
                              .firstNameController
                              .text,
                          fatherName: BlocProvider.of<BecomeATeacherBloc>(context)
                              .fatherNameController
                              .text,
                          lastName: BlocProvider.of<BecomeATeacherBloc>(context)
                              .lastNameController
                              .text,
                          descriptionAboutYou:
                              BlocProvider.of<BecomeATeacherBloc>(context)
                                  .descriptionController
                                  .text,
                          descriptionAboutTeachingLanguage:
                              BlocProvider.of<BecomeATeacherBloc>(context)
                                  .descriptionTeachingController
                                  .text,
                          video: BlocProvider.of<BecomeATeacherBloc>(context)
                              .videoBase64),
                      cardBecomeATeacher: CardBecomeATeacher(
                          nationalNumber:
                              BlocProvider.of<BecomeATeacherBloc>(context)
                                  .idCardController
                                  .text,
                          frontCardImage: BlocProvider.of<BecomeATeacherBloc>(context).listImageCard[0]!,
                          backCardImage: BlocProvider.of<BecomeATeacherBloc>(context).listImageCard[1]!),
                      listLanguageBecomeATeacher: listLanguageBecomeATeacher);
                  if (BlocProvider.of<BecomeATeacherBloc>(context)
                      .videoBase64
                      .isEmpty) {
                    showToastWidgetError("You must enter video about you.");
                  } else {
                    BlocProvider.of<BecomeATeacherBloc>(context).add(
                        OrderBecomeATeacherEvent(
                            becomeATeacherEntity: becomeATeacherEntity!));
                  }
                } else {
                  showToastWidgetError("You must enter images of certificate");
                }
              }
            },
            child: BlocConsumer<BecomeATeacherBloc, BecomeATeacherState>(
              listener: (context, state) {
                if (state is OrderBecomeATeacherErrorState) {
                  state.messages.map((e) => showToastWidgetError(e!)).toList();
                } else if (state is OrderBecomeATeacherSuccessState) {
                  showToastWidgetSuccess("your request success.");
                  Future.delayed(Duration.zero, () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  });
                }
              },
              builder: (context, state) {
                if (state is OrderBecomeATeacherLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                }
                return Text(
                  "Submit",
                  style: TextStyle(color: Colors.white, fontSize: 20.sp),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
