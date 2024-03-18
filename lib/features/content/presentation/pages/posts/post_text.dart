import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learny_project/features/admin/domain/entities/language_entity.dart';
import 'package:learny_project/features/content/domain/entities/level_content.dart';
import 'package:learny_project/features/content/domain/entities/type_posts_entity.dart';
import 'package:learny_project/features/content/presentation/pages/posts/add_posts.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import '../../../../../core/error/exception.dart';
import '../../../../admin/presentation/bloc/language_bloc/language_bloc.dart';
import '../../../../auth/data/datasources/local_data_sources/auth_local_data_sources.dart';
import '../../../../auth/data/models/user_model.dart';
import '../../../../auth/presentation/widgets/ElvatedButtonWdget.dart';
import '../../../domain/entities/posts_entity.dart';
import '../../../domain/entities/questions_entity.dart';
import '../../bloc/content/content_bloc.dart';
import 'package:learny_project/injection_container.dart' as di;

import '../../bloc/posts/posts_bloc.dart';


class PostText extends StatefulWidget {
  const PostText({Key? key}) : super(key: key);

  @override
  State<PostText> createState() => _PostTextState();
}

class _PostTextState extends State<PostText> {
  @override
  void initState() {
    BlocProvider.of<LanguageBloc>(context).add(GetAllLanguagesEvent());
    BlocProvider.of<ContentBloc>(context).add(GetLevelsContentEvent());
    BlocProvider.of<PostsBloc>(context).add(GetAllPostsEvent(
        pageId: "1",
        languageId: "1,2",
        typeId: "3",
        postLevelId: '1,2,3'));

    getUserInformation();
    super.initState();
  }
  final AuthLocalDataSources _authLocalDataSourcesImpl =
  di.sl<AuthLocalDataSources>();
  bool isTeacher = false;
  UserModel? userInformation;

  List<LevelContentEntity> listLevelForRequest = [
    LevelContentEntity(levelId: "1", levelName: "")
  ];
  String sLevel = "";
  List<TypePostsEntity> listCategoryForRequest = [
    TypePostsEntity(
      typeId: "3",
      typeName: "",
    )
  ];
  List<Language> listLanguageForRequest = [
    Language(languageId: "1", languageName: "")
  ];
  String sLanguage = "";

  late List<MultiSelectItem<LevelContentEntity>> itemsLevel = [
    MultiSelectItem<LevelContentEntity>(
        LevelContentEntity(levelId: "", levelName: ""), "")
  ];

  List<Language> language = [Language(languageId: "1", languageName: "")];
  late List<MultiSelectItem<Language>> itemsLanguage = [
    MultiSelectItem<Language>(Language(languageId: "", languageName: ""), "")
  ];

  List<LevelContentEntity> level = [
    LevelContentEntity(levelId: "1", levelName: "")
  ];

  late List<PostsEntity> postEntity = [];
  late PagesPage pagesPage;
  @override
  Widget build(BuildContext context) {
    if (userInformation != null) {
      userInformation!.roles!.map((e) {
        if (e.name == "teacher") {
          isTeacher = true;
        }
      }).toList();
    }
    return MultiBlocListener(
        listeners: [
          BlocListener<LanguageBloc, LanguageState>(listener: (context, state) {
            if (state is GetAllLanguagesSuccessState) {
              language = state.listAllLanguages;
              listLanguageForRequest = language;
              itemsLanguage = language
                  .map((e) => MultiSelectItem<Language>(e, e.languageName))
                  .toList();
              setState(() {});
            }
          }),
          BlocListener<ContentBloc, ContentState>(listener: (context, state) {
            if (state is GetLevelsContentSuccess) {
              level = state.listLevelContentEntity;
              listLevelForRequest = level;
              itemsLevel = level
                  .map((e) =>
                  MultiSelectItem<LevelContentEntity>(e, e.levelName))
                  .toList();
            }
          }),
        ],
        child: BlocBuilder<PostsBloc, PostsState>(
          builder: (context, state) {
            if (state is GetAllPostsSuccess) {
              pagesPage = state.listPosts.pages;
              postEntity = state.listPosts.postsEntity;
              return Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(20.0).w,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 250.w,

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Filter: ",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.sp),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            MultiSelectDialogField(
                              initialValue: level,
                              dialogHeight: 250.h,
                              dialogWidth: 250.w,
                              items: itemsLevel,
                              title: Text(
                                "Levels",
                                style: TextStyle(fontSize: 25.sp),
                              ),
                              selectedColor: Colors.blue,
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius:
                                const BorderRadius.all(Radius.circular(40)),
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                              ),
                              buttonText: Text(
                                "Levels",
                                style: TextStyle(
                                  color: Colors.blue[800],
                                  fontSize: 25.sp,
                                ),
                              ),
                              onConfirm: (results) {
                                setState(() {

                                  sLevel = "";
                                  sLanguage = "";
                                  listLevelForRequest = results;
                                  listLevelForRequest
                                      .map((e) =>
                                  sLevel = "$sLevel${e.levelId},")
                                      .toList();
                                  listLanguageForRequest
                                      .map((e) => sLanguage =
                                  "$sLanguage${e.languageId},")
                                      .toList();
                                  BlocProvider.of<PostsBloc>(context).add(
                                      GetAllPostsEvent(
                                          pageId: "1",
                                          languageId: sLanguage,
                                          typeId: "3",
                                          postLevelId: sLevel));
                                });
                              },
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            MultiSelectDialogField(
                              initialValue: language,
                              items: itemsLanguage,
                              dialogHeight: 250.h,
                              dialogWidth: 250.w,
                              title: Text(
                                "Languages",
                                style: TextStyle(fontSize: 25.sp),
                              ),
                              selectedColor: Colors.blue,
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius:
                                const BorderRadius.all(Radius.circular(40)),
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                              ),
                              buttonText: Text(
                                "Languages",
                                style: TextStyle(
                                  color: Colors.blue[800],
                                  fontSize: 25.sp,
                                ),
                              ),
                              onConfirm: (results) {
                                setState(() {

                                  sLevel = "";
                                  sLanguage = "";
                                  listLanguageForRequest = results;
                                  listLevelForRequest
                                      .map((e) =>
                                  sLevel = "$sLevel${e.levelId},")
                                      .toList();
                                  listLanguageForRequest
                                      .map((e) => sLanguage =
                                  "$sLanguage${e.languageId},")
                                      .toList();
                                  BlocProvider.of<PostsBloc>(context).add(
                                      GetAllPostsEvent(
                                          pageId: "1",
                                          languageId: sLanguage,
                                          typeId: "3",
                                          postLevelId: sLevel));
                                });
                              },
                            ),

                          ],
                        ),
                      ),
                      SizedBox(
                        width: 50.w,
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [

                              if(isTeacher)
                                SizedBox(
                                  height: 20.h,
                                ),
                              if(isTeacher)
                                SizedBox(
                                  width: 250.w,
                                  child: MyElevatedButton(onPressed: (){
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyStoriesParagraphs()));
                                  }, child: Text("My Posts",style: TextStyle(color: Colors.white,fontSize: 25.sp),)),
                                ),
                              if(isTeacher)
                                SizedBox(
                                  width: 20.w,
                                ),
                              if(isTeacher)
                                SizedBox(
                                  width: 250.w,
                                  child: MyElevatedButton(onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddPosts()));
                                  }, child: Text("Add Posts",style: TextStyle(color: Colors.white,fontSize: 25.sp),)),
                                ),


                            ],),
                            SizedBox(height: 20.h,),
                            Column(
                              children: List.generate(postEntity.length,
                                      (index) {
                                    return Column(
                                      children: [
                                        Container(
                                          width: 900.w,
                                          decoration: BoxDecoration(
                                            color: Colors.blue.withOpacity(0.1),
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(10)),
                                            border: Border.all(
                                              color: Colors.blue,
                                              width: 2,
                                            ),
                                          ),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.all(8.0)
                                                          .w,
                                                      child: Row(
                                                        children: [
                                                          CircleAvatar(
                                                            radius: 30.w,
                                                            backgroundImage: postEntity[
                                                            index]
                                                                .profileImageTeacher ==
                                                                null
                                                                ? const NetworkImage(
                                                                "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/925px-Unknown_person.jpg")
                                                                : NetworkImage(
                                                                "${postEntity[index].profileImageTeacher}"),
                                                          ),
                                                          SizedBox(
                                                            width: 20.w,
                                                          ),
                                                          Text(
                                                            "${postEntity[index].firstNameTeacher} ${postEntity[index].lastNameTeacher}",
                                                            style: TextStyle(
                                                                color: Colors.black,
                                                                fontSize: 25.sp,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(postEntity[index].timePost,style: TextStyle(color: Colors.black87,fontSize: 20.sp,),),
                                                        Icon(Icons.access_time_outlined,size: 20.w,),
                                                        TextButton(
                                                            onPressed: () {
                                                              BlocProvider.of<
                                                                  ContentBloc>(
                                                                  context)
                                                                  .add(FollowOrUnFollowEvent(
                                                                  teacherId:
                                                                  postEntity[
                                                                  index]
                                                                      .teacherId));
                                                              BlocProvider.of<
                                                                  PostsBloc>(
                                                                  context)
                                                                  .add(GetAllPostsEvent(
                                                                  pageId: "1",
                                                                  languageId:
                                                                  sLanguage,
                                                                  typeId: "3",
                                                                  postLevelId:
                                                                  sLevel));
                                                            },
                                                            child: postEntity[
                                                            index]
                                                                .isFollowingTeacher ==
                                                                false
                                                                ? Text(
                                                              "Follow",
                                                              style: TextStyle(
                                                                  color:
                                                                  Colors.blue,
                                                                  fontSize:
                                                                  25.sp),
                                                            )
                                                                : Text(
                                                              "Following",
                                                              style: TextStyle(
                                                                  color:
                                                                  Colors.grey,
                                                                  fontSize:
                                                                  25.sp),
                                                            )),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20.h,
                                                ),
                                                Center(
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: 10.h,
                                                        horizontal: 40.w),
                                                    child: Text(
                                                      postEntity[index]
                                                          .postTitle,
                                                      style: TextStyle(
                                                          fontSize: 25.sp,
                                                          color: Colors.black,fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                ),

                                                Center(
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: 10.h,
                                                        horizontal: 40.w),
                                                    child: Text(
                                                      postEntity[index]
                                                          .description,
                                                      style: TextStyle(
                                                          fontSize: 20.sp,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                                ///
                                                SizedBox(height: 20.h,),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                      ],
                                    );
                                  }),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            if (pagesPage.currentPage == "0")
                              Padding(
                                  padding: EdgeInsets.only(left: 300.w),
                                  child: Center(
                                    child: Text(
                                      "There are not any paragraph,try with other Filter",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 25.sp),
                                    ),
                                  )),
                            if (pagesPage.currentPage != "0")
                              BlocBuilder<PostsBloc, PostsState>(
                                builder: (context, state) {
                                  if (state is GetAllPostsSuccess) {
                                    return IntrinsicHeight(
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              if (int.parse(pagesPage
                                                  .currentPage) -
                                                  1 !=
                                                  0) {
                                                BlocProvider.of<PostsBloc>(
                                                    context)
                                                    .add(GetAllPostsEvent(
                                                    languageId: sLanguage,
                                                    pageId:
                                                    "${int.parse(pagesPage.currentPage) - 1}",
                                                    typeId: "3",
                                                    postLevelId:
                                                    sLevel));
                                              }
                                            },
                                            child: Container(
                                              height: 60.h,
                                              width: 60.w,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black38),
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8.w),
                                                  bottomLeft:
                                                  Radius.circular(8.w),
                                                ),
                                                color: int.parse(pagesPage
                                                    .currentPage) ==
                                                    1
                                                    ? Colors.black12
                                                    : Colors.white,
                                              ),
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 6.w),
                                              child: Icon(
                                                Icons.arrow_back_ios,
                                                color: int.parse(pagesPage
                                                    .currentPage) ==
                                                    1
                                                    ? Colors.blue.shade100
                                                    : Colors.blue.shade300,
                                              ),
                                            ),
                                          ),
                                          int.parse(pagesPage.lastPage) > 5
                                              ? Row(
                                            children: [
                                              int.parse(pagesPage
                                                  .currentPage) +
                                                  1 >
                                                  int.parse(pagesPage
                                                      .lastPage)
                                                  ? Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      BlocProvider.of<PostsBloc>(context).add(GetAllPostsEvent(
                                                          languageId:
                                                          sLanguage,
                                                          pageId:
                                                          "${int.parse(pagesPage.currentPage) - 4}",
                                                          typeId:
                                                          "3",
                                                          postLevelId:
                                                          sLevel));
                                                    },
                                                    child:
                                                    Container(
                                                      alignment:
                                                      Alignment
                                                          .center,
                                                      height: 60.h,
                                                      width: 60.w,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal:
                                                          10)
                                                          .w,
                                                      decoration:
                                                      BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .black38),
                                                        color: Colors
                                                            .white,
                                                      ),
                                                      child: Text(
                                                          "${int.parse(pagesPage.currentPage) - 4}"),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      BlocProvider.of<PostsBloc>(context).add(GetAllPostsEvent(
                                                          languageId:
                                                          sLanguage,
                                                          pageId:
                                                          "${int.parse(pagesPage.currentPage) - 3}",
                                                          typeId:
                                                          "3",
                                                          postLevelId:
                                                          sLevel));
                                                    },
                                                    child:
                                                    Container(
                                                      alignment:
                                                      Alignment
                                                          .center,
                                                      height: 60.h,
                                                      width: 60.w,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal:
                                                          10)
                                                          .w,
                                                      decoration:
                                                      BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .black38),
                                                        color: Colors
                                                            .white,
                                                      ),
                                                      child: Text(
                                                          "${int.parse(pagesPage.currentPage) - 3}"),
                                                    ),
                                                  )
                                                ],
                                              )
                                                  : int.parse(pagesPage
                                                  .currentPage) +
                                                  2 >
                                                  int.parse(
                                                      pagesPage
                                                          .lastPage)
                                                  ? InkWell(
                                                onTap: () {
                                                  BlocProvider.of<PostsBloc>(context).add(GetAllPostsEvent(
                                                      languageId:
                                                      sLanguage,
                                                      pageId:
                                                      "${int.parse(pagesPage.currentPage) - 3}",
                                                      typeId:
                                                      "3",
                                                      postLevelId:
                                                      sLevel));
                                                },
                                                child:
                                                Container(
                                                  alignment:
                                                  Alignment
                                                      .center,
                                                  height: 60.h,
                                                  width: 60.w,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal:
                                                      10)
                                                      .w,
                                                  decoration:
                                                  BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .black38),
                                                    color: Colors
                                                        .white,
                                                  ),
                                                  child: Text(
                                                      "${int.parse(pagesPage.currentPage) - 3}"),
                                                ),
                                              )
                                                  : Container(),
                                              int.parse(pagesPage
                                                  .currentPage) -
                                                  2 >
                                                  0
                                                  ? InkWell(
                                                onTap: () {
                                                  BlocProvider.of<
                                                      PostsBloc>(
                                                      context)
                                                      .add(GetAllPostsEvent(
                                                      languageId:
                                                      sLanguage,
                                                      pageId:
                                                      "${int.parse(pagesPage.currentPage) - 2}",
                                                      typeId:
                                                      "3",
                                                      postLevelId:
                                                      sLevel));
                                                },
                                                child: Container(
                                                  alignment:
                                                  Alignment
                                                      .center,
                                                  height: 60.h,
                                                  width: 60.w,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal:
                                                      10)
                                                      .w,
                                                  decoration:
                                                  BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .black38),
                                                    color: Colors
                                                        .white,
                                                  ),
                                                  child: Text(
                                                      "${int.parse(pagesPage.currentPage) - 2}"),
                                                ),
                                              )
                                                  : Container(),
                                              int.parse(pagesPage
                                                  .currentPage) -
                                                  1 >
                                                  0
                                                  ? InkWell(
                                                onTap: () {
                                                  BlocProvider.of<
                                                      PostsBloc>(
                                                      context)
                                                      .add(GetAllPostsEvent(
                                                      languageId:
                                                      sLanguage,
                                                      pageId:
                                                      "${int.parse(pagesPage.currentPage) - 1}",
                                                      typeId:
                                                      "3",
                                                      postLevelId:
                                                      sLevel));
                                                },
                                                child: Container(
                                                  alignment:
                                                  Alignment
                                                      .center,
                                                  height: 60.h,
                                                  width: 60.w,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal:
                                                      10)
                                                      .w,
                                                  decoration:
                                                  BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .black38),
                                                    color: Colors
                                                        .white,
                                                  ),
                                                  child: Text(
                                                      "${int.parse(pagesPage.currentPage) - 1}"),
                                                ),
                                              )
                                                  : Container(),
                                              Container(
                                                alignment:
                                                Alignment.center,
                                                height: 70.h,
                                                width: 70.w,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                      Colors.black38),
                                                  color: Colors.white,
                                                ),
                                                child: Text(
                                                  "${int.parse(pagesPage.currentPage)}",
                                                  style: TextStyle(
                                                      color: Colors
                                                          .blue.shade300),
                                                ),
                                              ),
                                              int.parse(pagesPage
                                                  .currentPage) +
                                                  1 <=
                                                  int.parse(pagesPage
                                                      .lastPage)
                                                  ? InkWell(
                                                onTap: () {
                                                  BlocProvider.of<
                                                      PostsBloc>(
                                                      context)
                                                      .add(GetAllPostsEvent(
                                                      languageId:
                                                      sLanguage,
                                                      pageId:
                                                      "${int.parse(pagesPage.currentPage) + 1}",
                                                      typeId:
                                                      "3",
                                                      postLevelId:
                                                      sLevel));
                                                },
                                                child: Container(
                                                  alignment:
                                                  Alignment
                                                      .center,
                                                  height: 60.h,
                                                  width: 60.w,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal:
                                                      10)
                                                      .w,
                                                  decoration:
                                                  BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .black38),
                                                    color: Colors
                                                        .white,
                                                  ),
                                                  child: Text(
                                                      "${int.parse(pagesPage.currentPage) + 1}"),
                                                ),
                                              )
                                                  : Container(),
                                              int.parse(pagesPage
                                                  .currentPage) +
                                                  2 <=
                                                  int.parse(pagesPage
                                                      .lastPage)
                                                  ? InkWell(
                                                onTap: () {
                                                  BlocProvider.of<
                                                      PostsBloc>(
                                                      context)
                                                      .add(GetAllPostsEvent(
                                                      languageId:
                                                      sLanguage,
                                                      pageId:
                                                      "${int.parse(pagesPage.currentPage) + 2}",
                                                      typeId:
                                                      "3",
                                                      postLevelId:
                                                      sLevel));
                                                },
                                                child: Container(
                                                  alignment:
                                                  Alignment
                                                      .center,
                                                  height: 60.h,
                                                  width: 60.w,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal:
                                                      10)
                                                      .w,
                                                  decoration:
                                                  BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .black38),
                                                    color: Colors
                                                        .white,
                                                  ),
                                                  child: Text(
                                                      "${int.parse(pagesPage.currentPage) + 2}"),
                                                ),
                                              )
                                                  : Container(),
                                              int.parse(pagesPage
                                                  .currentPage) -
                                                  1 <=
                                                  0
                                                  ? Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      BlocProvider.of<PostsBloc>(context).add(GetAllPostsEvent(
                                                          languageId:
                                                          sLanguage,
                                                          pageId:
                                                          "${int.parse(pagesPage.currentPage) + 3}",
                                                          typeId:
                                                          "3",
                                                          postLevelId:
                                                          sLevel));
                                                    },
                                                    child:
                                                    Container(
                                                      alignment:
                                                      Alignment
                                                          .center,
                                                      height: 60.h,
                                                      width: 60.w,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal:
                                                          10)
                                                          .w,
                                                      decoration:
                                                      BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .black38),
                                                        color: Colors
                                                            .white,
                                                      ),
                                                      child: Text(
                                                          "${int.parse(pagesPage.currentPage) + 3}"),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      BlocProvider.of<PostsBloc>(context).add(GetAllPostsEvent(
                                                          languageId:
                                                          sLanguage,
                                                          pageId:
                                                          "${int.parse(pagesPage.currentPage) + 4}",
                                                          typeId:
                                                          "3",
                                                          postLevelId:
                                                          sLevel));
                                                    },
                                                    child:
                                                    Container(
                                                      alignment:
                                                      Alignment
                                                          .center,
                                                      height: 60.h,
                                                      width: 60.w,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal:
                                                          10)
                                                          .w,
                                                      decoration:
                                                      BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .black38),
                                                        color: Colors
                                                            .white,
                                                      ),
                                                      child: Text(
                                                          "${int.parse(pagesPage.currentPage) + 4}"),
                                                    ),
                                                  )
                                                ],
                                              )
                                                  : int.parse(pagesPage
                                                  .currentPage) -
                                                  2 <=
                                                  0
                                                  ? InkWell(
                                                onTap: () {
                                                  BlocProvider.of<PostsBloc>(context).add(GetAllPostsEvent(
                                                      languageId:
                                                      sLanguage,
                                                      pageId:
                                                      "${int.parse(pagesPage.currentPage) + 3}",
                                                      typeId:
                                                      "3",
                                                      postLevelId:
                                                      sLevel));
                                                },
                                                child:
                                                Container(
                                                  alignment:
                                                  Alignment
                                                      .center,
                                                  height: 60.h,
                                                  width: 60.w,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal:
                                                      10)
                                                      .w,
                                                  decoration:
                                                  BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .black38),
                                                    color: Colors
                                                        .white,
                                                  ),
                                                  child: Text(
                                                      "${int.parse(pagesPage.currentPage) + 3}"),
                                                ),
                                              )
                                                  : Container(),
                                            ],
                                          )
                                              : Row(
                                            children: [
                                              for (int i = 1;
                                              i <=
                                                  int.parse(pagesPage
                                                      .lastPage);
                                              i++)
                                                InkWell(
                                                  onTap: () {
                                                    BlocProvider.of<
                                                        PostsBloc>(
                                                        context)
                                                        .add(GetAllPostsEvent(
                                                        languageId:
                                                        sLanguage,
                                                        pageId: i
                                                            .toString(),
                                                        typeId:
                                                        "3",
                                                        postLevelId:
                                                        sLevel));
                                                  },
                                                  child: Container(
                                                    alignment:
                                                    Alignment.center,
                                                    height: int.parse(
                                                        pagesPage
                                                            .currentPage) ==
                                                        i
                                                        ? 70.h
                                                        : 60.h,
                                                    width: int.parse(pagesPage
                                                        .currentPage) ==
                                                        i
                                                        ? 70.w
                                                        : 60.w,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal:
                                                        10)
                                                        .w,
                                                    decoration:
                                                    BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors
                                                              .black38),
                                                      color: Colors.white,
                                                    ),
                                                    child: Text("$i"),
                                                  ),
                                                ),
                                            ],
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if (int.parse(pagesPage
                                                  .currentPage) +
                                                  1 <=
                                                  int.parse(
                                                      pagesPage.lastPage)) {
                                                BlocProvider.of<PostsBloc>(
                                                    context)
                                                    .add(GetAllPostsEvent(
                                                    languageId: sLanguage,
                                                    pageId:
                                                    "${int.parse(pagesPage.currentPage) + 1}",
                                                    typeId: "3",
                                                    postLevelId:
                                                    sLevel));
                                              }
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 60.h,
                                              width: 60.w,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 6.w),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black38),
                                                borderRadius: BorderRadius.only(
                                                  topRight:
                                                  Radius.circular(8.w),
                                                  bottomRight:
                                                  Radius.circular(8.w),
                                                ),
                                                color: int.parse(pagesPage
                                                    .currentPage) ==
                                                    int.parse(
                                                        pagesPage.lastPage)
                                                    ? Colors.black12
                                                    : Colors.white,
                                              ),
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                color: int.parse(pagesPage
                                                    .currentPage) ==
                                                    int.parse(
                                                        pagesPage.lastPage)
                                                    ? Colors.blue.shade100
                                                    : Colors.blue.shade300,
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
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else if (state is GetAllPostsError) {
              return Scaffold(
                  body: Padding(
                    padding: const EdgeInsets.all(20.0).w,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 250.w,

                          height: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Filter: ",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30.sp),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              MultiSelectDialogField(
                                initialValue: level,
                                dialogHeight: 250.h,
                                dialogWidth: 250.w,
                                items: itemsLevel,
                                title: Text(
                                  "Levels",
                                  style: TextStyle(fontSize: 25.sp),
                                ),
                                selectedColor: Colors.blue,
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(40)),
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 2,
                                  ),
                                ),
                                buttonText: Text(
                                  "Levels",
                                  style: TextStyle(
                                    color: Colors.blue[800],
                                    fontSize: 25.sp,
                                  ),
                                ),
                                onConfirm: (results) {
                                  setState(() {

                                    sLevel = "";
                                    sLanguage = "";
                                    listLevelForRequest = results;
                                    listLevelForRequest
                                        .map((e) =>
                                    sLevel = "$sLevel${e.levelId},")
                                        .toList();

                                    listLanguageForRequest
                                        .map((e) => sLanguage =
                                    "$sLanguage${e.languageId},")
                                        .toList();
                                    BlocProvider.of<PostsBloc>(context).add(
                                        GetAllPostsEvent(
                                            pageId: "1",
                                            languageId: sLanguage,
                                            typeId: "3",
                                            postLevelId: sLevel));
                                  });
                                },
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              MultiSelectDialogField(
                                initialValue: language,
                                items: itemsLanguage,
                                dialogHeight: 250.h,
                                dialogWidth: 250.w,
                                title: Text(
                                  "Languages",
                                  style: TextStyle(fontSize: 25.sp),
                                ),
                                selectedColor: Colors.blue,
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(40)),
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 2,
                                  ),
                                ),
                                buttonText: Text(
                                  "Languages",
                                  style: TextStyle(
                                    color: Colors.blue[800],
                                    fontSize: 25.sp,
                                  ),
                                ),
                                onConfirm: (results) {
                                  setState(() {

                                    sLevel = "";
                                    sLanguage = "";
                                    listLanguageForRequest = results;
                                    listLevelForRequest
                                        .map((e) =>
                                    sLevel = "$sLevel${e.levelId},")
                                        .toList();

                                    listLanguageForRequest
                                        .map((e) => sLanguage =
                                    "$sLanguage${e.languageId},")
                                        .toList();
                                    BlocProvider.of<PostsBloc>(context).add(
                                        GetAllPostsEvent(
                                            pageId: "1",
                                            languageId: sLanguage,
                                            typeId:"3",
                                            postLevelId: sLevel));
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 50.w,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30.w),
                          child: Center(
                            child: Text(
                              "There are not any Texts.",
                              style:
                              TextStyle(color: Colors.black, fontSize: 25.sp),
                            ),
                          ),
                        )
                      ],
                    ),
                  ));
            } else {
              return Scaffold(
                  body: Padding(
                      padding: const EdgeInsets.all(20.0).w,
                      child: Row(children: [
                        SizedBox(
                          width: 250.w,
                          height: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Filter: ",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30.sp),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              MultiSelectDialogField(
                                initialValue: level,
                                dialogHeight: 250.h,
                                dialogWidth: 250.w,
                                items: itemsLevel,
                                title: Text(
                                  "Levels",
                                  style: TextStyle(fontSize: 25.sp),
                                ),
                                selectedColor: Colors.blue,
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(40)),
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 2,
                                  ),
                                ),
                                buttonText: Text(
                                  "Levels",
                                  style: TextStyle(
                                    color: Colors.blue[800],
                                    fontSize: 25.sp,
                                  ),
                                ),
                                onConfirm: (results) {
                                  setState(() {

                                    sLevel = "";
                                    sLanguage = "";
                                    listLevelForRequest = results;
                                    listLevelForRequest
                                        .map((e) =>
                                    sLevel = "$sLevel${e.levelId},")
                                        .toList();

                                    listLanguageForRequest
                                        .map((e) => sLanguage =
                                    "$sLanguage${e.languageId},")
                                        .toList();
                                    BlocProvider.of<PostsBloc>(context)
                                        .add(GetAllPostsEvent(
                                        pageId: "1",
                                        languageId: sLanguage,
                                        typeId:"3",
                                        postLevelId: sLevel));
                                  });
                                },
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              MultiSelectDialogField(
                                initialValue: language,
                                items: itemsLanguage,
                                dialogHeight: 250.h,
                                dialogWidth: 250.w,
                                title: Text(
                                  "Languages",
                                  style: TextStyle(fontSize: 25.sp),
                                ),
                                selectedColor: Colors.blue,
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(40)),
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 2,
                                  ),
                                ),
                                buttonText: Text(
                                  "Languages",
                                  style: TextStyle(
                                    color: Colors.blue[800],
                                    fontSize: 25.sp,
                                  ),
                                ),
                                onConfirm: (results) {
                                  setState(() {

                                    sLevel = "";
                                    sLanguage = "";
                                    listLanguageForRequest = results;
                                    listLevelForRequest
                                        .map((e) =>
                                    sLevel = "$sLevel${e.levelId},")
                                        .toList();

                                    listLanguageForRequest
                                        .map((e) => sLanguage =
                                    "$sLanguage${e.languageId},")
                                        .toList();
                                    BlocProvider.of<PostsBloc>(context)
                                        .add(GetAllPostsEvent(
                                        pageId: "1",
                                        languageId: sLanguage,
                                        typeId: "3",
                                        postLevelId: sLevel));
                                  });
                                },
                              ),

                            ],
                          ),
                        ),
                        SizedBox(
                          width: 200.w,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 300.w),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          ),
                        )
                      ])));
            }
          },
        ));
  }

  Future<void> getUserInformation() async {
    try {
      userInformation = await _authLocalDataSourcesImpl.getCachedUser();
      setState(() {});
    } catch (error) {
      if (error is EmptyCacheException) {
        userInformation = null;
        //  showToastWidget('EmptyCacheException');
      }
    }
  }

}
