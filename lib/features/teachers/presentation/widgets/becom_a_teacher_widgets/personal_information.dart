import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants.dart';
import '../../bloc/become_a_teacher/become_a_teacher_bloc.dart';

class PersonalInformation extends StatefulWidget {
  final GlobalKey personalInfoKey;

  const PersonalInformation({Key? key, required this.personalInfoKey})
      : super(key: key);

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(30).w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            key:widget.personalInfoKey ,
            margin: const EdgeInsets.all(20).w,
            child: Center(
              child: Text(
                "Personal information",
                style: TextStyle(
                  color: const Color(0xff30C7EC),
                  fontWeight: FontWeight.bold,
                  fontSize: 25.sp,
                ),
              ),
            ),
          ),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // person information
                Container(
                  padding: const EdgeInsets.all(10).w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: Text(
                        "First name:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.sp),
                      )),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        width: 400.w,
                        child: TextFormField(
                          controller:
                              BlocProvider.of<BecomeATeacherBloc>(context)
                                  .firstNameController,
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.normal,
                              color: Colors.black87),
                          onSaved: (value) {
                            BlocProvider.of<BecomeATeacherBloc>(context)
                                .firstNameController
                                .text = value!;
                          },
                          validator: (value){
                            if (value!.isEmpty) {
                              return 'Please enter your first name';
                            }
                          },
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontSize: 20.sp),
                              hintText: "Enter your first name",
                              border: const OutlineInputBorder(),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Constants.cyanColoraec6cf)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Constants.cyanColoraec6cf))),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                          child: Text(
                        "Father name:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.sp),
                      )),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        width: 400.w,
                        child: TextFormField(
                          validator: (value){
                            if (value!.isEmpty) {
                              return 'Please enter your father name';
                            }
                          },
                          controller:
                              BlocProvider.of<BecomeATeacherBloc>(context)
                                  .fatherNameController,
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.normal,
                              color: Colors.black87),
                          onSaved: (value) {
                            BlocProvider.of<BecomeATeacherBloc>(context)
                                .fatherNameController
                                .text = value!;
                          },
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontSize: 20.sp),
                              hintText: "Enter your father name",
                              border: const OutlineInputBorder(),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Constants.cyanColoraec6cf)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Constants.cyanColoraec6cf))),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                          child: Text(
                        "Last name:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.sp),
                      )),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        width: 400.w,
                        child: TextFormField(
                          validator:(value){
                            if (value!.isEmpty) {
                              return 'Please enter your last name';
                            }
                          } ,
                          controller:
                              BlocProvider.of<BecomeATeacherBloc>(context)
                                  .lastNameController,
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.normal,
                              color: Colors.black87),
                          onSaved: (value) {
                            BlocProvider.of<BecomeATeacherBloc>(context)
                                .lastNameController
                                .text = value!;
                          },
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontSize: 20.sp),
                              hintText: "Enter your last name",
                              border: const OutlineInputBorder(),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Constants.cyanColoraec6cf)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Constants.cyanColoraec6cf))),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                          child: Text(
                        "ID Card:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.sp),
                      )),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        width: 400.w,
                        child: TextFormField(
                          maxLength: 11,
                          validator: (value){

                            RegExp regex = RegExp(r'^[0-9]{11}$');
                            if (value!.isEmpty) {
                              return 'Please enter id card';
                            }else if(value.length < 11) {
                              return 'id card must be at least eleven characters long';
                            }
                            else if (!regex.hasMatch(value)) {
                              return 'Please enter only numbers';
                            }
                            },
                          controller:
                              BlocProvider.of<BecomeATeacherBloc>(context)
                                  .idCardController,
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.normal,
                              color: Colors.black87),
                          onSaved: (value) {
                            BlocProvider.of<BecomeATeacherBloc>(context)
                                .idCardController
                                .text = value!;
                          },
                          decoration: InputDecoration(
                              hintMaxLines: 1,
                              hintText: "Enter your id card",
                              hintStyle: TextStyle(fontSize: 20.sp),
                              border: const OutlineInputBorder(),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Constants.cyanColoraec6cf)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Constants.cyanColoraec6cf))),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
                // image card
                Container(
                  margin: const EdgeInsets.all(20).w,
                  padding: const EdgeInsets.all(10).w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Image card front:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.sp),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          DottedBorder(
                            strokeWidth: 2.w,
                            color: Colors.black87,
                            dashPattern: [6, 3, 2, 1],
                            child: GestureDetector(
                              onTap: () => context
                                  .read<BecomeATeacherBloc>()
                                  .add(PickImageFrontEvent()),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                        'assets/images/idcard.png',
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  height: 300.h,
                                  width: 380.w,
                                  child: BlocBuilder<BecomeATeacherBloc,
                                          BecomeATeacherState>(
                                      builder: (context, state) {
                                    if (BlocProvider.of<BecomeATeacherBloc>(
                                                context)
                                            .listImageCard[0] ==
                                        null) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          color: Colors.transparent,
                                        ),
                                      );
                                    } else {
                                      return kIsWeb
                                          ? Image.network(
                                              File(BlocProvider.of<
                                                              BecomeATeacherBloc>(
                                                          context)
                                                      .listImageCard[0]!
                                                      .path)
                                                  .path,
                                              fit: BoxFit.fill,
                                            )
                                          : Image.file(
                                              File(BlocProvider.of<
                                                          BecomeATeacherBloc>(
                                                      context)
                                                  .listImageCard[0]!
                                                  .path),
                                              fit: BoxFit.fill,
                                            );
                                    }
                                  })),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Column(
                        children: [
                          Text(
                            "Image card back:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.sp),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          DottedBorder(
                            strokeWidth: 2.w,
                            color: Colors.black87,
                            dashPattern: [6, 3, 2, 1],
                            child: GestureDetector(
                              onTap: () => context
                                  .read<BecomeATeacherBloc>()
                                  .add(PickImageBackEvent()),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/idcard.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  height: 300.h,
                                  width: 380.w,
                                  child: BlocBuilder<BecomeATeacherBloc,
                                          BecomeATeacherState>(
                                      builder: (context, state) {
                                    if (BlocProvider.of<BecomeATeacherBloc>(
                                                context)
                                            .listImageCard[1] ==
                                        null) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          color: Colors.transparent,
                                        ),
                                      );
                                    } else {
                                      return kIsWeb
                                          ? Image.network(
                                              File(BlocProvider.of<
                                                              BecomeATeacherBloc>(
                                                          context)
                                                      .listImageCard[1]!
                                                      .path)
                                                  .path,
                                              fit: BoxFit.fill,
                                            )
                                          : Image.file(File(BlocProvider.of<
                                                  BecomeATeacherBloc>(context)
                                              .listImageCard[1]!
                                              .path));
                                    }
                                  })),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
              padding: const EdgeInsets.only(left: 10).w,
              child: Container(
                child: Text(
                  "Description about you:",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
              )),
          Container(
            padding: const EdgeInsets.only(left: 10, top: 10).w,
            width: 1000.w,
            child: TextFormField(
              // onChanged: (value){
              //   setState(() {
              //     _characterCount = value.length;
              //   });
              // },
              validator: (value){
                if (value!.isEmpty) {
                  return 'Please this field is required';
                }else if (value.length<10) {
                  return 'You must enter at least 10 characters';
                }
              },
              maxLines: null,
              maxLength: 600,
              controller: BlocProvider.of<BecomeATeacherBloc>(context)
                  .descriptionController,
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.black87),
              onSaved: (value) {
                BlocProvider.of<BecomeATeacherBloc>(context)
                    .descriptionController
                    .text = value!;
              },
              decoration: InputDecoration(
                  hintMaxLines: 1,
                  hintText: "Enter some details about you...",
                  hintStyle: TextStyle(fontSize: 20.sp),
                  border: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Constants.cyanColoraec6cf)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Constants.cyanColoraec6cf))),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
              padding: const EdgeInsets.only(left: 10).w,
              child: Container(
                child: Text(
                  "Description about your way for teaching languages:",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
              )),
          Container(
            padding: const EdgeInsets.only(left: 10, top: 10).w,
            width: 1000.w,
            child: TextFormField(

              validator: (value){
                if (value!.isEmpty) {
                  return 'Please this field is required';
                }else if (value.length<10) {
                  return 'You must enter at least 10 characters';
                }
              },
              maxLines: null,
              maxLength: 600,
              controller: BlocProvider.of<BecomeATeacherBloc>(context)
                  .descriptionTeachingController,
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.black87),
              onSaved: (value) {
                BlocProvider.of<BecomeATeacherBloc>(context)
                    .descriptionTeachingController
                    .text = value!;
              },
              decoration: InputDecoration(
                  hintMaxLines: 1,
                  hintText:
                      "Enter some details about your way of your teaching of student ...",
                  hintStyle: TextStyle(fontSize: 20.sp),
                  border: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Constants.cyanColoraec6cf)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Constants.cyanColoraec6cf))),
            ),
          ),
        ],
      ),
    );
  }
}
