import 'dart:html' as html;
import 'dart:html';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../admin/presentation/bloc/certificate_type_bloc/certificate_type_bloc.dart';
import '../../../../admin/presentation/bloc/country_bloc/country_bloc.dart';
import '../../../../admin/presentation/bloc/donor_type_bloc/donor_type_bloc.dart';
import '../../../domain/entities/certificate.dart';
import '../../bloc/become_a_teacher/become_a_teacher_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/constants.dart';
import 'add_new_certificate.dart';
import 'build_drop_down_button.dart';
import 'delete_certificate.dart';
import 'pdf_viewer.dart';
import 'dart:ui' as ui;

class CertificateScreen extends StatefulWidget {
  final Certificate certificate;
  final int indexCertificate;
  final int indexTeachingLanguage;
  final bool visibleDelete;

  const CertificateScreen({
    Key? key,
    required this.certificate,
    required this.indexCertificate,
    required this.indexTeachingLanguage,
    required this.visibleDelete,
  }) : super(key: key);

  @override
  State<CertificateScreen> createState() => _CertificateScreenState();
}

enum TypeImageCertificate { pdf, image }

class _CertificateScreenState extends State<CertificateScreen> {
  bool isImage = true;
  String url1 = '';
  String base64 = '';

  Future<html.File?> _pickPdfFromGallery() async {
    if (kIsWeb) {
      final pdfFile = await pickPdfFromGallery();
      if (pdfFile != null) {
        final url = html.Url.createObjectUrl(pdfFile);
        final reader = html.FileReader();
        reader.readAsDataUrl(pdfFile);
        await reader.onLoad.first;
        base64 = reader.result as String;
        String b = base64.replaceFirst("application/pdf", "image/pdf");
        BlocProvider.of<BecomeATeacherBloc>(context)
            .listTeachingLanguagesScreens[widget.indexTeachingLanguage]
            .teachingLanguages
            .listCertificateScreen[widget.indexCertificate]
            .certificate
            .imagesOfCertificate = b;

        // ignore: undefined_prefixed_name
        ui.platformViewRegistry.registerViewFactory(
          url,
          (int viewId) => IFrameElement()
            ..src = url
            ..style.border = 'none'
            ..height = '100%'
            ..width = '100%',
        );
        setState(() {
          isImage = false;
          url1 = url;
          base64 = reader.result as String;
        });
      }
    }
  }

  Future<void> _askedToLead() async {
    switch (await showDialog<TypeImageCertificate>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text(
              'Choose type of image',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xff30C7EC)),
            ),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () async {
                  setState(() {
                    url1 = '';
                    isImage = false;
                  });
                  _pickPdfFromGallery();
                  Navigator.pop(context, TypeImageCertificate.pdf);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 15).w,
                  child: const Text('As PDF',
                      style: TextStyle(color: Colors.black54)),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  setState(() {
                    isImage = true;
                  });
                  BlocProvider.of<BecomeATeacherBloc>(context).add(
                      UpdateValueImageCertificateEvent(
                          indexTeachingLanguage: widget.indexTeachingLanguage,
                          indexCertificate: widget.indexCertificate));
                  Navigator.pop(context, TypeImageCertificate.image);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 15).w,
                  child: const Text('As jpg or png or...',
                      style: TextStyle(color: Colors.black54)),
                ),
              ),
            ],
          );
        })) {
      case TypeImageCertificate.pdf:
        break;
      case TypeImageCertificate.image:
        break;
      case null:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(20).w,
          child: Row(
            children: [
              Text(
                "Certificates",
                style: TextStyle(
                  color: const Color(0xff30C7EC),
                  fontWeight: FontWeight.bold,
                  fontSize: 25.sp,
                ),
              ),
              SizedBox(width: 100.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  addNewCertificate(widget.indexTeachingLanguage),
                  SizedBox(
                    width: 10.w,
                  ),
                  Visibility(
                      visible: widget.visibleDelete,
                      child: deleteCertificate(
                          indexTeachingLanguage: widget.indexTeachingLanguage,
                          indexCertificate: widget.indexCertificate))
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.only(left: 30).w,
                      child: Text(
                        "Certificate Type:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.sp),
                      )),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 8).w,
                    margin: const EdgeInsets.only(left: 30).w,
                    width: 400.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: Constants.cyanColoraec6cf),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child:
                        BlocBuilder<CertificateTypeBloc, CertificateTypeState>(
                      builder: (context, state) {
                        if (state is GetAllCertificateTypesSuccessState) {
                          return buildDropdownButton(
                            value: BlocProvider.of<BecomeATeacherBloc>(context)
                                .listTeachingLanguagesScreens[
                                    widget.indexTeachingLanguage]
                                .teachingLanguages
                                .listCertificateScreen[widget.indexCertificate]
                                .certificate
                                .certificateType
                                .certificateTypeName,
                            items: BlocProvider.of<CertificateTypeBloc>(context)
                                .listCertificateType
                                .map((e) => e.certificateTypeName)
                                .toList(),
                            onChange: (String? newValue) {
                              String id = "";
                              BlocProvider.of<CertificateTypeBloc>(context)
                                  .listCertificateType
                                  .map((e) {
                                if (e.certificateTypeName == newValue) {
                                  id = e.certificateTypeId;
                                }
                              }).toList();
                              BlocProvider.of<BecomeATeacherBloc>(context)
                                  .add(UpdateValueCertificateTypeEvent(
                                newValue: newValue!,
                                indexTeachingLanguage:
                                    widget.indexTeachingLanguage,
                                indexCertificate: widget.indexCertificate,
                                certificateTypeId: id,
                              ));
                            },
                          );
                        } else {
                          return Shimmer.fromColors(
                              baseColor: const Color(0xff46AEF7),
                              highlightColor: Colors.black38,
                              child: buildDropdownButton(
                                value:
                                    BlocProvider.of<BecomeATeacherBloc>(context)
                                        .listTeachingLanguagesScreens[
                                            widget.indexTeachingLanguage]
                                        .teachingLanguages
                                        .listCertificateScreen[
                                            widget.indexCertificate]
                                        .certificate
                                        .certificateType
                                        .certificateTypeName,
                                items: BlocProvider.of<CertificateTypeBloc>(
                                        context)
                                    .listCertificateType
                                    .map((e) => e.certificateTypeName)
                                    .toList(),
                                onChange: (String? newValue) {
                                  String id = "";
                                  BlocProvider.of<CertificateTypeBloc>(context)
                                      .listCertificateType
                                      .map((e) {
                                    if (e.certificateTypeName == newValue) {
                                      id = e.certificateTypeId;
                                    }
                                  }).toList();
                                  BlocProvider.of<BecomeATeacherBloc>(context)
                                      .add(UpdateValueCertificateTypeEvent(
                                    newValue: newValue!,
                                    indexTeachingLanguage:
                                        widget.indexTeachingLanguage,
                                    indexCertificate: widget.indexCertificate,
                                    certificateTypeId: id,
                                  ));
                                },
                              ));
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 30).w,
                      child: Text(
                        "Certificate Date:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.sp),
                      )),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextButton(

                    onPressed: () {
                      _pickDate();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10)
                          .w,
                      margin: const EdgeInsets.only(left: 20).w,
                      width: 400.w,
                      decoration: BoxDecoration(
                        border: Border.all(color: Constants.cyanColoraec6cf),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child:
                          BlocBuilder<BecomeATeacherBloc, BecomeATeacherState>(
                        builder: (context, state) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BlocProvider.of<BecomeATeacherBloc>(context)
                                          .listTeachingLanguagesScreens[
                                              widget.indexTeachingLanguage]
                                          .teachingLanguages
                                          .listCertificateScreen[
                                              widget.indexCertificate]
                                          .certificate
                                          .dateCertificate ==
                                      ''
                                  ? Text(
                                      "Enter date of certificate",
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black54),
                                    )
                                  : Text(
                                      BlocProvider.of<BecomeATeacherBloc>(
                                              context)
                                          .listTeachingLanguagesScreens[
                                              widget.indexTeachingLanguage]
                                          .teachingLanguages
                                          .listCertificateScreen[
                                              widget.indexCertificate]
                                          .certificate
                                          .dateCertificate,
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          color: Colors.black54)),
                              const Icon(Icons.date_range_outlined)
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 30).w,
                      child: Text(
                        "Donor Type:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.sp),
                      )),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 8).w,
                    margin: const EdgeInsets.only(left: 30).w,
                    width: 400.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: Constants.cyanColoraec6cf),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: BlocBuilder<DonorTypeBloc, DonorTypeState>(
                        builder: (context, state) {
                      if (state is GetAllDonorTypesSuccessState) {
                        return buildDropdownButton(
                            value: BlocProvider.of<BecomeATeacherBloc>(context)
                                .listTeachingLanguagesScreens[
                                    widget.indexTeachingLanguage]
                                .teachingLanguages
                                .listCertificateScreen[widget.indexCertificate]
                                .certificate
                                .donorCertificate
                                .donorType
                                .donorTypeName,
                            items: BlocProvider.of<DonorTypeBloc>(context)
                                .listDonorType
                                .map((e) => e.donorTypeName)
                                .toList(),
                            onChange: (String? newValue) {
                              String id = "";
                              BlocProvider.of<DonorTypeBloc>(context)
                                  .listDonorType
                                  .map((e) {
                                if (e.donorTypeName == newValue) {
                                  id = e.donorTypeId;
                                }
                              }).toList();
                              BlocProvider.of<BecomeATeacherBloc>(context).add(
                                  UpdateValueDonorTypeEvent(
                                      newValue: newValue!,
                                      indexTeachingLanguage:
                                          widget.indexTeachingLanguage,
                                      indexCertificate: widget.indexCertificate,
                                      donorTypeId: id));
                            });
                      }
                      return Shimmer.fromColors(
                          baseColor: const Color(0xff46AEF7),
                          highlightColor: Colors.black38,
                          child: buildDropdownButton(
                              value:
                                  BlocProvider.of<BecomeATeacherBloc>(context)
                                      .listTeachingLanguagesScreens[
                                          widget.indexTeachingLanguage]
                                      .teachingLanguages
                                      .listCertificateScreen[
                                          widget.indexCertificate]
                                      .certificate
                                      .donorCertificate
                                      .donorType
                                      .donorTypeName,
                              items: BlocProvider.of<DonorTypeBloc>(context)
                                  .listDonorType
                                  .map((e) => e.donorTypeName)
                                  .toList(),
                              onChange: (String? newValue) {
                                String id = "";
                                BlocProvider.of<DonorTypeBloc>(context)
                                    .listDonorType
                                    .map((e) {
                                  if (e.donorTypeName == newValue) {
                                    id = e.donorTypeId;
                                  }
                                }).toList();
                                BlocProvider.of<BecomeATeacherBloc>(context)
                                    .add(UpdateValueDonorTypeEvent(
                                        newValue: newValue!,
                                        indexTeachingLanguage:
                                            widget.indexTeachingLanguage,
                                        indexCertificate:
                                            widget.indexCertificate,
                                        donorTypeId: id));
                              }));
                    }),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 30).w,
                      child: Text(
                        "Donor Country:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.sp),
                      )),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 8).w,
                    margin: const EdgeInsets.only(left: 30).w,
                    width: 400.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: Constants.cyanColoraec6cf),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: BlocBuilder<CountryBloc, CountryState>(
                        builder: (context, state) {
                      if (state is GetAllCountriesSuccessState) {
                        return buildDropdownButton(
                            value: BlocProvider.of<BecomeATeacherBloc>(context)
                                .listTeachingLanguagesScreens[
                                    widget.indexTeachingLanguage]
                                .teachingLanguages
                                .listCertificateScreen[widget.indexCertificate]
                                .certificate
                                .donorCertificate
                                .donorCountry
                                .countryName,
                            items: BlocProvider.of<CountryBloc>(context)
                                .listCountries
                                .map((e) => e.countryName)
                                .toList(),
                            onChange: (String? newValue) {
                              String id = "";
                              BlocProvider.of<CountryBloc>(context)
                                  .listCountries
                                  .map((e) {
                                if (e.countryName == newValue) {
                                  id = e.countryId;
                                }
                              }).toList();
                              BlocProvider.of<BecomeATeacherBloc>(context).add(
                                  UpdateValueDonorCountryEvent(
                                      newValue: newValue!,
                                      indexTeachingLanguage:
                                          widget.indexTeachingLanguage,
                                      indexCertificate: widget.indexCertificate,
                                      donorCountyId: id));
                            });
                      }
                      return Shimmer.fromColors(
                          baseColor: const Color(0xff46AEF7),
                          highlightColor: Colors.black38,
                          child: buildDropdownButton(
                              value:
                                  BlocProvider.of<BecomeATeacherBloc>(context)
                                      .listTeachingLanguagesScreens[
                                          widget.indexTeachingLanguage]
                                      .teachingLanguages
                                      .listCertificateScreen[
                                          widget.indexCertificate]
                                      .certificate
                                      .donorCertificate
                                      .donorCountry
                                      .countryName,
                              items: BlocProvider.of<CountryBloc>(context)
                                  .listCountries
                                  .map((e) => e.countryName)
                                  .toList(),
                              onChange: (String? newValue) {
                                String id = "";
                                BlocProvider.of<CountryBloc>(context)
                                    .listCountries
                                    .map((e) {
                                  if (e.countryName == newValue) {
                                    id = e.countryId;
                                  }
                                }).toList();

                                BlocProvider.of<BecomeATeacherBloc>(context)
                                    .add(UpdateValueDonorCountryEvent(
                                        newValue: newValue!,
                                        indexTeachingLanguage:
                                            widget.indexTeachingLanguage,
                                        indexCertificate:
                                            widget.indexCertificate,
                                        donorCountyId: id));
                              }));
                    }),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 30).w,
                      child: Text(
                        "Donor Name:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.sp),
                      )),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8).w,
                    margin: const EdgeInsets.only(left: 22).w,
                    width: 420.w,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please this filed is required.";
                        }
                      },
                      controller: BlocProvider.of<BecomeATeacherBloc>(context)
                          .listTeachingLanguagesScreens[
                              widget.indexTeachingLanguage]
                          .teachingLanguages
                          .listCertificateScreen[widget.indexCertificate]
                          .certificate
                          .donorCertificate
                          .donorName,
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.black87),
                      onSaved: (value) {
                        BlocProvider.of<BecomeATeacherBloc>(context)
                            .listTeachingLanguagesScreens[
                                widget.indexTeachingLanguage]
                            .teachingLanguages
                            .listCertificateScreen[widget.indexCertificate]
                            .certificate
                            .donorCertificate
                            .donorName
                            .text = value!;
                      },
                      decoration: InputDecoration(
                          hintMaxLines: 1,
                          hintText: "Enter of donor name",
                          hintStyle: TextStyle(fontSize: 20.sp),
                          border: const OutlineInputBorder(),
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Constants.cyanColoraec6cf)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Constants.cyanColoraec6cf))),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 30).w,
                      child: Text(
                        "Add image of certificate:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.sp),
                      )),
                  SizedBox(
                    height: 10.h,
                  ),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await _askedToLead();
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 30.w,
                            ),
                            DottedBorder(
                              strokeWidth: 2,
                              color: Colors.black87,
                              dashPattern: [6, 3, 2, 1],
                              child: Container(
                                  width: 450.w,
                                  height: 350.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: isImage
                                      ? BlocBuilder<BecomeATeacherBloc,
                                              BecomeATeacherState>(
                                          builder: (context, state) {
                                          if (BlocProvider.of<
                                                  BecomeATeacherBloc>(context)
                                              .listTeachingLanguagesScreens[
                                                  widget.indexTeachingLanguage]
                                              .teachingLanguages
                                              .listCertificateScreen[
                                                  widget.indexCertificate]
                                              .certificate
                                              .imageCertificate
                                              .path
                                              .isEmpty) {
                                            return const Icon(
                                              Icons
                                                  .add_photo_alternate_outlined,
                                              size: 50,
                                            );
                                          } else {
                                            return SizedBox(
                                              width: 400.w,
                                              height: 300.h,
                                              child: Image.network(
                                                BlocProvider.of<
                                                            BecomeATeacherBloc>(
                                                        context)
                                                    .listTeachingLanguagesScreens[
                                                        widget
                                                            .indexTeachingLanguage]
                                                    .teachingLanguages
                                                    .listCertificateScreen[
                                                        widget.indexCertificate]
                                                    .certificate
                                                    .imageCertificate
                                                    .path,
                                                fit: BoxFit.fill,
                                              ),
                                            );
                                          }
                                        })
                                      : InkWell(
                                          onTap: () async {
                                            await _askedToLead();
                                          },
                                          child: url1.isEmpty
                                              ? const Icon(
                                                  Icons
                                                      .add_photo_alternate_outlined,
                                                  size: 50,
                                                )
                                              : PdfViewer(
                                                  url: url1,
                                                  width: 400.w,
                                                  height: 300.h,
                                                ),
                                        )),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                          top: 5,
                          right: 5,
                          child: IconButton(
                              onPressed: () async {
                                await _askedToLead();
                              },
                              icon: Icon(Icons.edit))),
                    ],
                  ),
                ],
              ),
              SizedBox(
                  height: 500,
                  width: 400.w,
                  child: Image.asset("assets/images/certificate.png")),
            ],
          ),
        ),
        Visibility(
            visible: widget.visibleDelete,
            child: Divider(
              indent: 200.w,
              endIndent: 200.w,
            ))
      ],
    );
  }
 Future<void> _pickDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            // Change the colors and styles of the date picker here
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              surface: Colors.blue,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        BlocProvider.of<BecomeATeacherBloc>(context).dateCertificate =
            selectedDate;
        BlocProvider.of<BecomeATeacherBloc>(context).add(
            UpdateValueCertificateDateEvent(
                newValue: DateFormat('yyyy-MM-dd').format(
                    BlocProvider.of<BecomeATeacherBloc>(context)
                        .dateCertificate),
                indexTeachingLanguage: widget.indexTeachingLanguage,
                indexCertificate: widget.indexCertificate));
      });
    }
  }
}
