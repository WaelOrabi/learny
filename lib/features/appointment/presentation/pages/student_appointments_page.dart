import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learny_project/features/appointment/domain/entities/get_student_appointments_entity.dart';
import 'package:learny_project/features/appointment/presentation/bloc/get_student_appointments_bloc/get_student_appointments_bloc.dart';
import 'package:learny_project/features/appointment/presentation/pages/student_appointment_page.dart';

import '../../../teachers/presentation/widgets/becom_a_teacher_widgets/footer.dart';
import '../widgets/search_bar_student_appointments_widget.dart';

class StudentAppointmentsPage extends StatefulWidget {
  const StudentAppointmentsPage({super.key});

  @override
  State<StudentAppointmentsPage> createState() =>
      _StudentAppointmentsPageState();
}

class _StudentAppointmentsPageState extends State<StudentAppointmentsPage> {
  List<DataEntity> listAppointments = [];
  late GetStudentAppointmentsEntity getStudentAppointmentsEntity;
  ScrollController scroll = ScrollController();

  List<DataEntity> appointments = [];

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<GetStudentAppointmentsBloc>(context).add(
        GetStudentAppointments(
            status: BlocProvider.of<GetStudentAppointmentsBloc>(context).list,
            numberPage: 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const SearchBarStudentAppointmentsWidget(),
          BlocBuilder<GetStudentAppointmentsBloc, GetStudentAppointmentsState>(
              builder: (context, state) {
            if (state is GetStudentAppointmentsLoaded) {
              getStudentAppointmentsEntity = state.getStudentAppointmentsEntity;
              listAppointments = state.getStudentAppointmentsEntity.data;
              if (listAppointments.isEmpty) {
                return const Expanded(child:Center(
                  child: Text('There are not any Appointments'),
                ));
              }
              return Expanded(
                child: SingleChildScrollView(
                  controller: scroll,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.8),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: listAppointments.length,
                            itemBuilder: (context, index) {
                              return Center(
                                child: Container(
                                  padding: EdgeInsets.all(10.w),
                                  margin: EdgeInsets.all(8.w),
                                  decoration: const BoxDecoration(
                                      color: Colors.white, border: Border()),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          listAppointments[index]
                                                      .teacher
                                                      .userInfo
                                                      .personalImage ==
                                                  null
                                              ? ProfilePicture(
                                                  name:
                                                      "${listAppointments[index].teacher.userInfo.firstName} ${listAppointments[index].teacher.userInfo.lastName}",
                                                  radius: 40.w,
                                                  fontsize: 30.sp,
                                                  random: true,
                                                )
                                              : CircleAvatar(
                                                  radius: 40.w,
                                                  backgroundImage: NetworkImage(
                                                      "${listAppointments[index].teacher.userInfo.personalImage}"),
                                                ),
                                          SizedBox(
                                            width: 15.w,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Name: ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20.sp,
                                                        color: Colors.blue),
                                                  ),
                                                  Text(
                                                    "${listAppointments[index].teacher.userInfo.firstName} ${listAppointments[index].teacher.userInfo.lastName}",
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 20.sp),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Email: ",
                                                    style: TextStyle(
                                                        fontSize: 20.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.blue),
                                                  ),
                                                  Text(
                                                      listAppointments[index]
                                                          .teacher
                                                          .userInfo
                                                          .email,
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 20.sp)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Date: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.sp,
                                                color: Colors.blue),
                                          ),
                                          Text(listAppointments[index].date,
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 20.sp)),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Time: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.sp,
                                                color: Colors.blue),
                                          ),
                                          Text(listAppointments[index].time,
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 20.sp)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Status: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.sp,
                                                color: Colors.blue),
                                          ),
                                          Text(
                                              listAppointments[index]
                                                  .appointmentStatus,
                                              style: TextStyle(
                                                  fontSize: 20.sp,
                                                  color: listAppointments[index]
                                                              .appointmentStatus ==
                                                          "Pending"
                                                      ? Colors.orange
                                                      : listAppointments[index]
                                                                  .appointmentStatus ==
                                                              "accepting"
                                                          ? Colors.green
                                                          : Colors.red)),
                                        ],
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return GetStudentAppointmentPage(
                                                appointmentId:
                                                    listAppointments[index].id,
                                              );
                                            }));
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                "Show details",
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 20.sp),
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              const Icon(
                                                Icons
                                                    .arrow_circle_right_outlined,
                                                color: Colors.blue,
                                              )
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      BlocBuilder<GetStudentAppointmentsBloc,
                              GetStudentAppointmentsState>(
                          builder: (context, state) {
                        if (state is GetStudentAppointmentsLoaded) {
                          return IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (getStudentAppointmentsEntity
                                                .meta.currentPage! -
                                            1 !=
                                        0) {
                                      BlocProvider.of<GetStudentAppointmentsBloc>(
                                              context)
                                          .add(GetStudentAppointments(
                                              status: BlocProvider.of<
                                                          GetStudentAppointmentsBloc>(
                                                      context)
                                                  .list,
                                              numberPage:
                                                  getStudentAppointmentsEntity
                                                          .meta.currentPage! -
                                                      1));
                                    }
                                  },
                                  child: Container(
                                    height: 60.h,
                                    width: 60.w,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black38),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8.w),
                                        bottomLeft: Radius.circular(8.w),
                                      ),
                                      color: getStudentAppointmentsEntity
                                                  .meta.currentPage ==
                                              1
                                          ? Colors.black12
                                          : Colors.white,
                                    ),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 6.w),
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: getStudentAppointmentsEntity
                                                  .meta.currentPage ==
                                              1
                                          ? Colors.blue.shade100
                                          : Colors.blue.shade300,
                                    ),
                                  ),
                                ),
                                getStudentAppointmentsEntity.meta.lastPage! > 5
                                    ? Row(
                                        children: [
                                          getStudentAppointmentsEntity
                                                          .meta.currentPage! +
                                                      1 >
                                                  getStudentAppointmentsEntity
                                                      .meta.lastPage!
                                              ? Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        BlocProvider.of<
                                                                    GetStudentAppointmentsBloc>(
                                                                context)
                                                            .add(GetStudentAppointments(
                                                                status: BlocProvider.of<
                                                                            GetStudentAppointmentsBloc>(
                                                                        context)
                                                                    .list,
                                                                numberPage:
                                                                    getStudentAppointmentsEntity
                                                                            .meta
                                                                            .currentPage! -
                                                                        4));
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 60.h,
                                                        width: 60.w,
                                                        padding: const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10)
                                                            .w,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .black38),
                                                          color: Colors.white,
                                                        ),
                                                        child: Text(
                                                            "${getStudentAppointmentsEntity.meta.currentPage! - 4}"),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        BlocProvider.of<
                                                                    GetStudentAppointmentsBloc>(
                                                                context)
                                                            .add(GetStudentAppointments(
                                                                status: BlocProvider.of<
                                                                            GetStudentAppointmentsBloc>(
                                                                        context)
                                                                    .list,
                                                                numberPage:
                                                                    getStudentAppointmentsEntity
                                                                            .meta
                                                                            .currentPage! -
                                                                        3));
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 60.h,
                                                        width: 60.w,
                                                        padding: const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10)
                                                            .w,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .black38),
                                                          color: Colors.white,
                                                        ),
                                                        child: Text(
                                                            "${getStudentAppointmentsEntity.meta.currentPage! - 3}"),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : getStudentAppointmentsEntity
                                                              .meta
                                                              .currentPage! +
                                                          2 >
                                                      getStudentAppointmentsEntity
                                                          .meta.lastPage!
                                                  ? InkWell(
                                                      onTap: () {
                                                        BlocProvider.of<
                                                                    GetStudentAppointmentsBloc>(
                                                                context)
                                                            .add(GetStudentAppointments(
                                                                status: BlocProvider.of<
                                                                            GetStudentAppointmentsBloc>(
                                                                        context)
                                                                    .list,
                                                                numberPage:
                                                                    getStudentAppointmentsEntity
                                                                            .meta
                                                                            .currentPage! -
                                                                        3));
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 60.h,
                                                        width: 60.w,
                                                        padding: const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10)
                                                            .w,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .black38),
                                                          color: Colors.white,
                                                        ),
                                                        child: Text(
                                                            "${getStudentAppointmentsEntity.meta.currentPage! - 3}"),
                                                      ),
                                                    )
                                                  : Container(),
                                          getStudentAppointmentsEntity
                                                          .meta.currentPage! -
                                                      2 >
                                                  0
                                              ? InkWell(
                                                  onTap: () {
                                                    BlocProvider.of<
                                                                GetStudentAppointmentsBloc>(
                                                            context)
                                                        .add(GetStudentAppointments(
                                                            status: BlocProvider
                                                                    .of<GetStudentAppointmentsBloc>(
                                                                        context)
                                                                .list,
                                                            numberPage:
                                                                getStudentAppointmentsEntity
                                                                        .meta
                                                                        .currentPage! -
                                                                    2));
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 60.h,
                                                    width: 60.w,
                                                    padding: const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 10)
                                                        .w,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color:
                                                              Colors.black38),
                                                      color: Colors.white,
                                                    ),
                                                    child: Text(
                                                        "${getStudentAppointmentsEntity.meta.currentPage! - 2}"),
                                                  ),
                                                )
                                              : Container(),
                                          getStudentAppointmentsEntity
                                                          .meta.currentPage! -
                                                      1 >
                                                  0
                                              ? InkWell(
                                                  onTap: () {
                                                    BlocProvider.of<
                                                                GetStudentAppointmentsBloc>(
                                                            context)
                                                        .add(GetStudentAppointments(
                                                            status: BlocProvider
                                                                    .of<GetStudentAppointmentsBloc>(
                                                                        context)
                                                                .list,
                                                            numberPage:
                                                                getStudentAppointmentsEntity
                                                                        .meta
                                                                        .currentPage! -
                                                                    1));
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 60.h,
                                                    width: 60.w,
                                                    padding: const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 10)
                                                        .w,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color:
                                                              Colors.black38),
                                                      color: Colors.white,
                                                    ),
                                                    child: Text(
                                                        "${getStudentAppointmentsEntity.meta.currentPage! - 1}"),
                                                  ),
                                                )
                                              : Container(),
                                          Container(
                                            alignment: Alignment.center,
                                            height: 70.h,
                                            width: 70.w,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black38),
                                              color: Colors.white,
                                            ),
                                            child: Text(
                                              "${getStudentAppointmentsEntity.meta.currentPage!}",
                                              style: TextStyle(
                                                  color: Colors.blue.shade300),
                                            ),
                                          ),
                                          getStudentAppointmentsEntity
                                                          .meta.currentPage! +
                                                      1 <=
                                                  getStudentAppointmentsEntity
                                                      .meta.lastPage!
                                              ? InkWell(
                                                  onTap: () {
                                                    BlocProvider.of<
                                                                GetStudentAppointmentsBloc>(
                                                            context)
                                                        .add(GetStudentAppointments(
                                                            status: BlocProvider
                                                                    .of<GetStudentAppointmentsBloc>(
                                                                        context)
                                                                .list,
                                                            numberPage:
                                                                getStudentAppointmentsEntity
                                                                        .meta
                                                                        .currentPage! +
                                                                    1));
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 60.h,
                                                    width: 60.w,
                                                    padding: const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 10)
                                                        .w,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color:
                                                              Colors.black38),
                                                      color: Colors.white,
                                                    ),
                                                    child: Text(
                                                        "${getStudentAppointmentsEntity.meta.currentPage! + 1}"),
                                                  ),
                                                )
                                              : Container(),
                                          getStudentAppointmentsEntity
                                                          .meta.currentPage! +
                                                      2 <=
                                                  getStudentAppointmentsEntity
                                                      .meta.lastPage!
                                              ? InkWell(
                                                  onTap: () {
                                                    BlocProvider.of<
                                                                GetStudentAppointmentsBloc>(
                                                            context)
                                                        .add(GetStudentAppointments(
                                                            status: BlocProvider
                                                                    .of<GetStudentAppointmentsBloc>(
                                                                        context)
                                                                .list,
                                                            numberPage:
                                                                getStudentAppointmentsEntity
                                                                        .meta
                                                                        .currentPage! +
                                                                    2));
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 60.h,
                                                    width: 60.w,
                                                    padding: const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 10)
                                                        .w,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color:
                                                              Colors.black38),
                                                      color: Colors.white,
                                                    ),
                                                    child: Text(
                                                        "${getStudentAppointmentsEntity.meta.currentPage! + 2}"),
                                                  ),
                                                )
                                              : Container(),
                                          getStudentAppointmentsEntity
                                                          .meta.currentPage! -
                                                      1 <=
                                                  0
                                              ? Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        BlocProvider.of<
                                                                    GetStudentAppointmentsBloc>(
                                                                context)
                                                            .add(GetStudentAppointments(
                                                                status: BlocProvider.of<
                                                                            GetStudentAppointmentsBloc>(
                                                                        context)
                                                                    .list,
                                                                numberPage:
                                                                    getStudentAppointmentsEntity
                                                                            .meta
                                                                            .currentPage! +
                                                                        3));
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 60.h,
                                                        width: 60.w,
                                                        padding: const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10)
                                                            .w,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .black38),
                                                          color: Colors.white,
                                                        ),
                                                        child: Text(
                                                            "${getStudentAppointmentsEntity.meta.currentPage! + 3}"),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        BlocProvider.of<
                                                                    GetStudentAppointmentsBloc>(
                                                                context)
                                                            .add(GetStudentAppointments(
                                                                status: BlocProvider.of<
                                                                            GetStudentAppointmentsBloc>(
                                                                        context)
                                                                    .list,
                                                                numberPage:
                                                                    getStudentAppointmentsEntity
                                                                            .meta
                                                                            .currentPage! +
                                                                        4));
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 60.h,
                                                        width: 60.w,
                                                        padding: const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10)
                                                            .w,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .black38),
                                                          color: Colors.white,
                                                        ),
                                                        child: Text(
                                                            "${getStudentAppointmentsEntity.meta.currentPage! + 4}"),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : getStudentAppointmentsEntity
                                                              .meta
                                                              .currentPage! -
                                                          2 <=
                                                      0
                                                  ? InkWell(
                                                      onTap: () {
                                                        BlocProvider.of<
                                                                    GetStudentAppointmentsBloc>(
                                                                context)
                                                            .add(GetStudentAppointments(
                                                                status: BlocProvider.of<
                                                                            GetStudentAppointmentsBloc>(
                                                                        context)
                                                                    .list,
                                                                numberPage:
                                                                    getStudentAppointmentsEntity
                                                                            .meta
                                                                            .currentPage! +
                                                                        3));
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 60.h,
                                                        width: 60.w,
                                                        padding: const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10)
                                                            .w,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .black38),
                                                          color: Colors.white,
                                                        ),
                                                        child: Text(
                                                            "${getStudentAppointmentsEntity.meta.currentPage! + 3}"),
                                                      ),
                                                    )
                                                  : Container(),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          for (int i = 1;
                                              i <=
                                                  getStudentAppointmentsEntity
                                                      .meta.lastPage!;
                                              i++)
                                            InkWell(
                                              onTap: () {
                                                BlocProvider.of<
                                                            GetStudentAppointmentsBloc>(
                                                        context)
                                                    .add(GetStudentAppointments(
                                                        status: BlocProvider.of<
                                                                    GetStudentAppointmentsBloc>(
                                                                context)
                                                            .list,
                                                        numberPage: i));
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                height:
                                                    getStudentAppointmentsEntity
                                                                .meta
                                                                .currentPage! ==
                                                            i
                                                        ? 70.h
                                                        : 60.h,
                                                width:
                                                    getStudentAppointmentsEntity
                                                                .meta
                                                                .currentPage! ==
                                                            i
                                                        ? 70.w
                                                        : 60.w,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                            horizontal: 10)
                                                        .w,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black38),
                                                  color: Colors.white,
                                                ),
                                                child: Text("$i"),
                                              ),
                                            ),
                                        ],
                                      ),
                                InkWell(
                                  onTap: () {
                                    if (getStudentAppointmentsEntity
                                                .meta.currentPage! +
                                            1 <=
                                        getStudentAppointmentsEntity
                                            .meta.lastPage!) {
                                      BlocProvider.of<GetStudentAppointmentsBloc>(
                                              context)
                                          .add(GetStudentAppointments(
                                              status: BlocProvider.of<
                                                          GetStudentAppointmentsBloc>(
                                                      context)
                                                  .list,
                                              numberPage:
                                                  getStudentAppointmentsEntity
                                                          .meta.currentPage! +
                                                      1));
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 60.h,
                                    width: 60.w,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 6.w),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black38),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8.w),
                                        bottomRight: Radius.circular(8.w),
                                      ),
                                      color: getStudentAppointmentsEntity
                                                  .meta.currentPage ==
                                              getStudentAppointmentsEntity
                                                  .meta.lastPage!
                                          ? Colors.black12
                                          : Colors.white,
                                    ),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: getStudentAppointmentsEntity
                                                  .meta.currentPage ==
                                              getStudentAppointmentsEntity
                                                  .meta.lastPage!
                                          ? Colors.blue.shade100
                                          : Colors.blue.shade300,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }),
                      SizedBox(
                        height: 30.h,
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is GetStudentAppointmentsLoading) {
              return Expanded(
                child: Column(
                  
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                ),
              );
            } else {
              return Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    const Center(
                      child: Text("There are not any Appointments."),
                    ),
                  ],
                ),
              );
            }
          }),
          footer(context),
        ],
      ),
    );
  }
}
