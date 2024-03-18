import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learny_project/features/admin/presentation/bloc/language_bloc/language_bloc.dart';
import 'package:learny_project/features/teachers/domain/entities/teachers_entity.dart';
import 'package:learny_project/features/teachers/presentation/pages/show_details_teacher.dart';
import 'package:learny_project/features/teachers/presentation/widgets/becom_a_teacher_widgets/footer.dart';
import '../bloc/get_teachers/get_teachers_bloc.dart';

class ShowTeachers extends StatefulWidget {
  const ShowTeachers({Key? key}) : super(key: key);

  @override
  State<ShowTeachers> createState() => _ShowTeachersState();
}

class _ShowTeachersState extends State<ShowTeachers> {
  final ScrollController _scroll = ScrollController();
  late TeachersEntity _teachersEntity;
  List<ItemTeacherEntity> _listItemTeachersEntity = [];

  @override
  void initState() {
    BlocProvider.of<LanguageBloc>(context).add(GetAllLanguagesEvent());

    super.initState();
  }

  final List<String> _listIdLanguages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: BlocConsumer<LanguageBloc, LanguageState>(
        listener: (context, state) {
          if (state is GetAllLanguagesSuccessState) {
            state.listAllLanguages.map((e) {
              _listIdLanguages.add(e.languageId);
            }).toList();
            BlocProvider.of<GetTeachersBloc>(context)
                .add(GetTeachers(languages: _listIdLanguages, page: 1));

          }
        },
        builder: (context, state1) {
          return SingleChildScrollView(
              controller: _scroll,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),

                  BlocBuilder<GetTeachersBloc, GetTeachersState>(
                      builder: (context, state) {
                    if (state is GetTeachersSuccessState) {
                      _teachersEntity = state.teachers;
                      _listItemTeachersEntity = _teachersEntity.data;
                      return ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.8),
                        child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: _listItemTeachersEntity.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShowDetailsTeacher(teacherId: _listItemTeachersEntity[index].teacherId,)));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8).w,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${_listItemTeachersEntity[index].userInfo.firstName} ${_listItemTeachersEntity[index].userInfo.lastName}",
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        CircleAvatar(
                                          radius: 100.w,
                                          backgroundImage:
                                              _listItemTeachersEntity[index]
                                                          .userInfo
                                                          .personalImage ==
                                                      null
                                                  ? const NetworkImage(
                                                      "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/925px-Unknown_person.jpg",
                                                    )
                                                  : NetworkImage(
                                                      _listItemTeachersEntity[
                                                              index]
                                                          .userInfo
                                                          .personalImage!,
                                                    ),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                                "${_listItemTeachersEntity[index].userInfo.nationality!.name}",
                                                style: TextStyle(
                                                    fontSize: 30.sp,
                                                    color: Colors.black54)),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            _listItemTeachersEntity[index]
                                                        .userInfo
                                                        .gender ==
                                                    "male"
                                                ? Icon(
                                                    Icons.male,
                                                    color: Colors.black54,
                                                    size: 40.w,
                                                  )
                                                : Icon(
                                                    Icons.female,
                                                    color: Colors.black54,
                                                    size: 40.w,
                                                  ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                    _listItemTeachersEntity[
                                                            index]
                                                        .rating
                                                        .toStringAsFixed(2),
                                                    style: TextStyle(
                                                        color: Colors
                                                            .yellow.shade600,
                                                        fontSize: 30.sp)),
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.yellow.shade600,
                                                  size: 30.w,
                                                )
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              "Teaching",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.sp,
                                                  color: Colors.black),
                                            ),
                                            Column(
                                              children: List.generate(
                                                _listItemTeachersEntity[index]
                                                    .languages
                                                    .length,
                                                (index1) => Padding(
                                                  padding:
                                                      const EdgeInsets.all(6.0)
                                                          .w,
                                                  child: Text(
                                                    _listItemTeachersEntity[
                                                            index]
                                                        .languages[index1]
                                                        .language,
                                                    style: TextStyle(
                                                        fontSize: 20.sp,
                                                        color: Colors.black54),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "Level",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.sp,
                                                  color: Colors.black),
                                            ),
                                            Column(
                                              children: List.generate(
                                                _listItemTeachersEntity[index]
                                                    .languages
                                                    .length,
                                                (index1) => Padding(
                                                  padding:
                                                      const EdgeInsets.all(6.0)
                                                          .w,
                                                  child: Text(
                                                    _listItemTeachersEntity[
                                                            index]
                                                        .languages[index1]
                                                        .level,
                                                    style: TextStyle(
                                                        fontSize: 20.sp,
                                                        color: Colors.black54),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "Experience",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.sp,
                                                  color: Colors.black),
                                            ),
                                            Column(
                                              children: List.generate(
                                                _listItemTeachersEntity[index]
                                                    .languages
                                                    .length,
                                                (index1) => Padding(
                                                  padding:
                                                      const EdgeInsets.all(6.0)
                                                          .w,
                                                  child: Text(
                                                    "${_listItemTeachersEntity[index].languages[index1].yearsOfExperience} y",
                                                    style: TextStyle(
                                                        fontSize: 20.sp,
                                                        color: Colors.black54),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 10 / 2,
                            crossAxisCount: 3,
                            mainAxisExtent: 430.w,
                            mainAxisSpacing: 10.h,
                            crossAxisSpacing: 10.h,
                          ),
                        ),
                      );
                    } else if (state is GetTeachersLoadingState ||
                        state1 is GetAllLanguagesLoadingState) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 30.h,
                          ),
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          SizedBox(
                            height: 30.h,
                          ),
                          const Center(
                            child: Text("There aren't any teachers."),
                          ),
                        ],
                      );
                    }
                  }),
                  SizedBox(
                    height: 30.h,
                  ),
                  BlocBuilder<GetTeachersBloc, GetTeachersState>(
                    builder: (context, state) {
                      if (state is GetTeachersSuccessState) {
                        return IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  if(_teachersEntity.meta.currentPage! -1!=0) {
                                    BlocProvider.of<GetTeachersBloc>(context)
                                      .add(GetTeachers(languages: _listIdLanguages, page:_teachersEntity.meta.currentPage! -1 ));
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
                                    color:_teachersEntity.meta.currentPage == 1?Colors.black12: Colors.white,
                                  ),
                                  margin: EdgeInsets.symmetric(horizontal: 6.w),
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color:_teachersEntity.meta.currentPage == 1?Colors.blue.shade100: Colors.blue.shade300,
                                  ),
                                ),
                              ),
                              _teachersEntity.meta.lastPage! > 5
                                  ?

                                  Row(
                                      children: [
                                        _teachersEntity.meta.currentPage! + 1 >
                                                _teachersEntity.meta.lastPage!
                                            ? Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      BlocProvider.of<GetTeachersBloc>(context)
                                                          .add(GetTeachers(languages: _listIdLanguages, page: _teachersEntity.meta.currentPage! - 4));
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
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.black38),
                                                        color: Colors.white,
                                                      ),
                                                      child: Text(
                                                          "${_teachersEntity.meta.currentPage! - 4}"),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      BlocProvider.of<GetTeachersBloc>(context)
                                                          .add(GetTeachers(languages: _listIdLanguages, page: _teachersEntity.meta.currentPage! - 3));
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
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.black38),
                                                        color: Colors.white,
                                                      ),
                                                      child: Text(
                                                          "${_teachersEntity.meta.currentPage! - 3}"),
                                                    ),
                                                  )
                                                ],
                                              )
                                            : _teachersEntity
                                                            .meta.currentPage! +
                                                        2 >
                                                    _teachersEntity
                                                        .meta.lastPage!
                                                ? InkWell(
                                                    onTap: () {
                                                      BlocProvider.of<GetTeachersBloc>(context)
                                                          .add(GetTeachers(languages: _listIdLanguages, page: _teachersEntity.meta.currentPage! - 3));
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
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.black38),
                                                        color: Colors.white,
                                                      ),
                                                      child: Text(
                                                          "${_teachersEntity.meta.currentPage! - 3}"),
                                                    ),
                                                  )
                                                : Container(),
                                        _teachersEntity.meta.currentPage! - 2 >
                                                0
                                            ? InkWell(
                                                onTap: () {
                                                  BlocProvider.of<GetTeachersBloc>(context)
                                                      .add(GetTeachers(languages: _listIdLanguages, page: _teachersEntity.meta.currentPage! - 2));
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
                                                        color: Colors.black38),
                                                    color: Colors.white,
                                                  ),
                                                  child: Text(
                                                      "${_teachersEntity.meta.currentPage! - 2}"),
                                                ),
                                              )
                                            : Container(),
                                        _teachersEntity.meta.currentPage! - 1 >
                                                0
                                            ? InkWell(
                                                onTap: () {
                                                  BlocProvider.of<GetTeachersBloc>(context)
                                                      .add(GetTeachers(languages: _listIdLanguages, page: _teachersEntity.meta.currentPage! - 1));
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
                                                        color: Colors.black38),
                                                    color: Colors.white,
                                                  ),
                                                  child: Text(
                                                      "${_teachersEntity.meta.currentPage! - 1}"),
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
                                            "${_teachersEntity.meta.currentPage!}",
                                            style: TextStyle(
                                                color: Colors.blue.shade300),
                                          ),
                                        ),
                                        _teachersEntity.meta.currentPage! + 1 <=
                                                _teachersEntity.meta.lastPage!
                                            ? InkWell(
                                                onTap: () {
                                                  BlocProvider.of<GetTeachersBloc>(context)
                                                      .add(GetTeachers(languages: _listIdLanguages, page: _teachersEntity.meta.currentPage! + 1));
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
                                                        color: Colors.black38),
                                                    color: Colors.white,
                                                  ),
                                                  child: Text(
                                                      "${_teachersEntity.meta.currentPage! + 1}"),
                                                ),
                                              )
                                            : Container(),
                                        _teachersEntity.meta.currentPage! + 2 <=
                                                _teachersEntity.meta.lastPage!
                                            ? InkWell(
                                                onTap: () {
                                                  BlocProvider.of<GetTeachersBloc>(context)
                                                      .add(GetTeachers(languages: _listIdLanguages, page: _teachersEntity.meta.currentPage! + 2));
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
                                                        color: Colors.black38),
                                                    color: Colors.white,
                                                  ),
                                                  child: Text(
                                                      "${_teachersEntity.meta.currentPage! + 2}"),
                                                ),
                                              )
                                            : Container(),
                                        _teachersEntity.meta.currentPage! - 1 <=
                                                0
                                            ? Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      BlocProvider.of<GetTeachersBloc>(context)
                                                          .add(GetTeachers(languages: _listIdLanguages, page: _teachersEntity.meta.currentPage! + 3));
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
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.black38),
                                                        color: Colors.white,
                                                      ),
                                                      child: Text(
                                                          "${_teachersEntity.meta.currentPage! + 3}"),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      BlocProvider.of<GetTeachersBloc>(context)
                                                          .add(GetTeachers(languages: _listIdLanguages, page: _teachersEntity.meta.currentPage! + 4));
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
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.black38),
                                                        color: Colors.white,
                                                      ),
                                                      child: Text(
                                                          "${_teachersEntity.meta.currentPage! + 4}"),
                                                    ),
                                                  )
                                                ],
                                              )
                                            : _teachersEntity
                                                            .meta.currentPage! -
                                                        2 <=
                                                    0
                                                ? InkWell(
                                                    onTap: () {
                                                      BlocProvider.of<GetTeachersBloc>(context)
                                                          .add(GetTeachers(languages: _listIdLanguages, page: _teachersEntity.meta.currentPage! + 3));
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
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.black38),
                                                        color: Colors.white,
                                                      ),
                                                      child: Text(
                                                          "${_teachersEntity.meta.currentPage! + 3}"),
                                                    ),
                                                  )
                                                : Container(),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        for (int i = 1;
                                            i <= _teachersEntity.meta.lastPage!;
                                            i++)
                                          InkWell(
                                            onTap: () {
                                              BlocProvider.of<GetTeachersBloc>(context)
                                                  .add(GetTeachers(languages: _listIdLanguages, page: i));
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: _teachersEntity
                                                          .meta.currentPage! ==
                                                      i
                                                  ? 70.h
                                                  : 60.h,
                                              width: _teachersEntity
                                                          .meta.currentPage! ==
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
                                  if(_teachersEntity.meta.currentPage!+1<=_teachersEntity.meta.lastPage!) {
                                    BlocProvider.of<GetTeachersBloc>(context)
                                        .add(GetTeachers(languages: _listIdLanguages, page: _teachersEntity.meta.currentPage!+1));
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 60.h,
                                  width: 60.w,
                                  margin: EdgeInsets.symmetric(horizontal: 6.w),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black38),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8.w),
                                      bottomRight: Radius.circular(8.w),
                                    ),
                                    color:_teachersEntity.meta.currentPage == _teachersEntity.meta.lastPage!?Colors.black12: Colors.white,
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color:_teachersEntity.meta.currentPage == _teachersEntity.meta.lastPage!?Colors.blue.shade100: Colors.blue.shade300,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                  SizedBox(
                    height: 30.h,
                  ),

                 BlocBuilder<GetTeachersBloc, GetTeachersState>(builder: (context,state){
                   if(state is GetTeachersSuccessState){
                    return footer(context);
                   }else {
                     return Container();
                   }
                 }),
                ],
              )
          );
        },
      ),
    );
  }
}
