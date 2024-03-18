import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../admin/domain/entities/level_entity.dart';
import '../../../../admin/presentation/bloc/language_bloc/language_bloc.dart';
import '../../../../admin/presentation/bloc/level_bloc/level_bloc.dart';
import '../../../data/models/teacher_request_details_model.dart';
import '../../../domain/entities/teaching_languages.dart';
import '../../bloc/become_a_teacher/become_a_teacher_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/constants.dart';
import '../../../../admin/domain/entities/language_entity.dart';
import 'add_new_language.dart';
import 'build_drop_down_button.dart';
import 'certificate.dart';
import 'delete_language.dart';

class TeachingLanguagesScreen extends StatefulWidget {
  final TeachingLanguages teachingLanguages;
  final int indexTeachingLanguage;
  final bool deleteVisibility;
  final List<Language> listLanguages;
  final List<Level> listLevels;

  TeachingLanguagesScreen(
      {Key? key,
      required this.teachingLanguages,
      required this.indexTeachingLanguage,
      required this.deleteVisibility,
      required this.listLanguages,
      required this.listLevels})
      : super(key: key);

  @override
  State<TeachingLanguagesScreen> createState() =>
      _TeachingLanguagesScreenState();
}

class _TeachingLanguagesScreenState extends State<TeachingLanguagesScreen> {
  @override
  void initState() {
    BlocProvider.of<LevelBloc>(context).add(GetAllLevelsEvent());
    BlocProvider.of<LanguageBloc>(context).add(GetAllLanguagesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(30).w,
        margin: const EdgeInsets.symmetric(horizontal: 20).w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(20).w,
              child: Center(
                child: Row(
                  children: [
                    Text(
                      "Teaching language",
                      style: TextStyle(
                        color: const Color(0xff30C7EC),
                        fontWeight: FontWeight.bold,
                        fontSize: 25.sp,
                      ),
                    ),
                    SizedBox(width: 100.w),
                    Row(
                      children: [
                        addNewLanguages(
                            listLanguages: widget.listLanguages,
                            listLevels: widget.listLevels),
                        SizedBox(
                          height: 10.w,
                        ),
                        Visibility(
                            visible: widget.deleteVisibility,
                            child: deleteLanguage(
                                indexTeachingLanguage:
                                    widget.indexTeachingLanguage))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
                margin: const EdgeInsets.only(left: 30).w,
                child: Text(
                  "Language:",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                )),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 30).w,
                  padding: const EdgeInsets.symmetric(horizontal: 8).w,
                  width: 400.w,
                  decoration: BoxDecoration(
                    border: Border.all(color: Constants.cyanColoraec6cf),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: BlocBuilder<LanguageBloc, LanguageState>(
                      builder: (context, state) {
                    if (state is GetAllLanguagesSuccessState) {
                      return buildDropdownButton(
                        value: BlocProvider.of<BecomeATeacherBloc>(context)
                            .listTeachingLanguagesScreens[
                                widget.indexTeachingLanguage]
                            .teachingLanguages
                            .language
                            .languageName,
                        items: BlocProvider.of<LanguageBloc>(context)
                            .listLanguages
                            .map((e) => e.languageName)
                            .toList(),
                        onChange: (String? newValue) {
                          String id = "";
                          BlocProvider.of<LanguageBloc>(context)
                              .listLanguages
                              .map((e) {
                            if (e.languageName == newValue) {
                              id = e.languageId;
                            }
                          }).toList();
                          BlocProvider.of<BecomeATeacherBloc>(context).add(
                              UpdateValueLanguageEvent(
                                  newValue: newValue!,
                                  indexTeachingLanguage:
                                      widget.indexTeachingLanguage,
                                  languageId: id));
                        },
                      );
                    }
                    return Shimmer.fromColors(
                        baseColor: Color(0xff30C7EC),
                        highlightColor: Colors.black38,
                        child:  buildDropdownButton(
                          value: BlocProvider.of<BecomeATeacherBloc>(context)
                              .listTeachingLanguagesScreens[
                                  widget.indexTeachingLanguage]
                              .teachingLanguages
                              .language
                              .languageName,
                          items: BlocProvider.of<LanguageBloc>(context)
                              .listLanguages
                              .map((e) => e.languageName)
                              .toList(),
                          onChange: (String? newValue) {
                            String id = "";
                            BlocProvider.of<LanguageBloc>(context)
                                .listLanguages
                                .map((e) {
                              if (e.languageName == newValue) {
                                id = e.languageId;
                              }
                            }).toList();

                            BlocProvider.of<BecomeATeacherBloc>(context).add(
                                UpdateValueLanguageEvent(
                                    newValue: newValue!,
                                    indexTeachingLanguage:
                                        widget.indexTeachingLanguage,
                                    languageId: id));
                          },
                        ));
                  }),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
                margin: const EdgeInsets.only(left: 30).w,
                child: Text(
                  "Level:",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                )),
            SizedBox(
              height: 10.h,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8).w,
              margin: const EdgeInsets.only(left: 30).w,
              width: 400.w,
              decoration: BoxDecoration(
                border: Border.all(color: Constants.cyanColoraec6cf),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: BlocBuilder<LevelBloc, LevelState>(
                builder: (context, state) {
                  if (state is GetAllLevelsSuccessState) {
                    return buildDropdownButton(
                      value: BlocProvider.of<BecomeATeacherBloc>(context)
                          .listTeachingLanguagesScreens[
                              widget.indexTeachingLanguage]
                          .teachingLanguages
                          .level
                          .levelName,
                      items: BlocProvider.of<LevelBloc>(context)
                          .listLevels
                          .map((e) => e.levelName)
                          .toList(),
                      onChange: (String? newValue) {
                        String id = "";
                        BlocProvider.of<LevelBloc>(context).listLevels.map((e) {
                          if (e.levelName == newValue) {
                            id = e.levelId;
                          }
                        }).toList();
                        BlocProvider.of<BecomeATeacherBloc>(context).add(
                            UpdateValueLevelEvent(
                                newValue: newValue!,
                                indexTeachingLanguage:
                                    widget.indexTeachingLanguage,
                                levelId: id));
                      },
                    );
                  }
                  return Shimmer.fromColors(
                      baseColor: Color(0xff46AEF7),
                      highlightColor: Colors.black38,
                      child: buildDropdownButton(
                        value: BlocProvider.of<BecomeATeacherBloc>(context)
                            .listTeachingLanguagesScreens[
                                widget.indexTeachingLanguage]
                            .teachingLanguages
                            .level
                            .levelName,
                        items: BlocProvider.of<LevelBloc>(context)
                            .listLevels
                            .map((e) => e.levelName)
                            .toList(),
                        onChange: (String? newValue) {
                          String id = "";
                          BlocProvider.of<LevelBloc>(context)
                              .listLevels
                              .map((e) {
                            if (e.levelName == newValue) {
                              id = e.levelId;
                            }
                          }).toList();
                          BlocProvider.of<BecomeATeacherBloc>(context).add(
                              UpdateValueLevelEvent(
                                  newValue: newValue!,
                                  indexTeachingLanguage:
                                      widget.indexTeachingLanguage,
                                  levelId: id));
                        },
                      ));
                },
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
                margin: const EdgeInsets.only(left: 30).w,
                child: Text(
                  "Years of experience:",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                )),
            SizedBox(
              height: 10.h,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10).w,
              margin: const EdgeInsets.only(left: 22).w,
              width: 420.w,
              child: TextFormField(
                validator: (value) {
                  RegExp regex = RegExp(r'^[0-9]');
                  if (value!.isEmpty) {
                    return 'Please this field is required.';
                  } else if (!regex.hasMatch(value)) {
                    return 'Please the years should be number';
                  }
                },
                controller: BlocProvider.of<BecomeATeacherBloc>(context)
                    .listTeachingLanguagesScreens[widget.indexTeachingLanguage]
                    .teachingLanguages
                    .yearOfExperience,
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87),
                onSaved: (value) {
                  BlocProvider.of<BecomeATeacherBloc>(context)
                      .listTeachingLanguagesScreens[
                          widget.indexTeachingLanguage]
                      .teachingLanguages
                      .yearOfExperience
                      .text = value!;
                },
                decoration: InputDecoration(
                    hintMaxLines: 1,
                    hintText: "Enter of year experience",
                    hintStyle: TextStyle(fontSize: 20.sp),
                    border: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Constants.cyanColoraec6cf)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Constants.cyanColoraec6cf))),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50.w),
              child: BlocBuilder<BecomeATeacherBloc, BecomeATeacherState>(
                builder: (context, state) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: BlocProvider.of<BecomeATeacherBloc>(context)
                          .listTeachingLanguagesScreens[
                              widget.indexTeachingLanguage]
                          .teachingLanguages
                          .listCertificateScreen
                          .length,
                      itemBuilder: (context, index) {
                        return BlocProvider.of<BecomeATeacherBloc>(context)
                                    .listTeachingLanguagesScreens[
                                        widget.indexTeachingLanguage]
                                    .teachingLanguages
                                    .listCertificateScreen
                                    .length ==
                                1
                            ? CertificateScreen(
                                certificate:
                                    BlocProvider.of<BecomeATeacherBloc>(context)
                                        .listTeachingLanguagesScreens[
                                            widget.indexTeachingLanguage]
                                        .teachingLanguages
                                        .listCertificateScreen[index]
                                        .certificate,
                                visibleDelete: false,
                                indexCertificate: index,
                                indexTeachingLanguage:
                                    widget.indexTeachingLanguage,
                              )
                            : CertificateScreen(
                                certificate:
                                    BlocProvider.of<BecomeATeacherBloc>(context)
                                        .listTeachingLanguagesScreens[
                                            widget.indexTeachingLanguage]
                                        .teachingLanguages
                                        .listCertificateScreen[index]
                                        .certificate,
                                visibleDelete: true,
                                indexCertificate: index,
                                indexTeachingLanguage:
                                    widget.indexTeachingLanguage,
                              );
                      });
                },
              ),
            ),
            Visibility(
                visible: widget.deleteVisibility,
                child: Divider(
                  indent: 100.w,
                  endIndent: 100.w,
                ))
          ],
        ),
    );
  }
}
