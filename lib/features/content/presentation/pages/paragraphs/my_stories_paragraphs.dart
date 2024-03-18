import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learny_project/features/admin/presentation/bloc/language_bloc/language_bloc.dart';
import 'package:learny_project/features/content/domain/entities/paragraphs_entity.dart';
import 'package:learny_project/features/content/presentation/bloc/paragraphs/paragraphs_bloc.dart';
import 'package:learny_project/features/content/presentation/pages/paragraphs/update_story_paragraph.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import '../../../../../core/error/exception.dart';
import '../../../../admin/domain/entities/language_entity.dart';
import '../../../../auth/data/datasources/local_data_sources/auth_local_data_sources.dart';
import '../../../../auth/data/models/user_model.dart';
import '../../../../auth/presentation/widgets/ElvatedButtonWdget.dart';
import '../../../domain/entities/category_paragraph.dart';
import '../../../domain/entities/level_content.dart';
import '../../../domain/entities/questions_entity.dart';
import '../../bloc/content/content_bloc.dart';

import 'package:learny_project/injection_container.dart' as di;

import 'add_story_paragraph.dart';
class MyStoriesParagraphs extends StatefulWidget {
  const MyStoriesParagraphs({Key? key}) : super(key: key);

  @override
  State<MyStoriesParagraphs> createState() => _MyStoriesParagraphsState();
}

class _MyStoriesParagraphsState extends State<MyStoriesParagraphs> {

  @override
  void initState() {

    BlocProvider.of<LanguageBloc>(context).add(GetAllLanguagesEvent());
    BlocProvider.of<ContentBloc>(context).add(GetLevelsContentEvent());
    BlocProvider.of<ContentBloc>(context).add(GetCategoriesParagraphEvent());
    BlocProvider.of<ParagraphsBloc>(context).add(GetMyParagraphsEvent(
        pageId: "1",
        languageId: "1,2,3,4",
        categoryId: "1,2,3,4",
        paragraphLevelId: '1,2,3,4')); // TODO: implement initState
    getUserInformation();

    // TODO: implement initState
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
  List<CategoryParagraphEntity> listCategoryForRequest = [
    CategoryParagraphEntity(
      categoryId: "1",
      categoryName: "",
    )
  ];
  String sType = "";
  List<Language> listLanguageForRequest = [
    Language(languageId: "1", languageName: "")
  ];
  String sLanguage = "";

  late List<MultiSelectItem<LevelContentEntity>> itemsLevel = [
    MultiSelectItem<LevelContentEntity>(
        LevelContentEntity(levelId: "", levelName: ""), "")
  ];
  late List<MultiSelectItem<CategoryParagraphEntity>> itemsType = [
    MultiSelectItem<CategoryParagraphEntity>(
        CategoryParagraphEntity(
          categoryId: "",
          categoryName: "",
        ),
        "")
  ];
  List<Language> language = [Language(languageId: "1", languageName: "")];
  late List<MultiSelectItem<Language>> itemsLanguage = [
    MultiSelectItem<Language>(Language(languageId: "", languageName: ""), "")
  ];

  List<LevelContentEntity> level = [
    LevelContentEntity(levelId: "1", levelName: "")
  ];
  List<CategoryParagraphEntity> type = [
    CategoryParagraphEntity(
      categoryId: "1",
      categoryName: "",
    )
  ];

  late List<ParagraphsEntity> _paragraphsEntity = [];
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
          if (state is GetCategoriesParagraphSuccess) {
            type = state.listCategoryParagraphEntity;
            print(type);
            listCategoryForRequest = type;
            setState(() {});
            itemsType = type
                .map((e) => MultiSelectItem<CategoryParagraphEntity>(
                e, e.categoryName))
                .toList();
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
      child: BlocBuilder<ParagraphsBloc, ParagraphsState>(
  builder: (context, state) {
      if (state is GetMyParagraphsSuccess) {
        pagesPage = state.listParagraphs.pages;
        _paragraphsEntity = state.listParagraphs.paragraphsEntity;

        return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0).w,
          child: Row(
            children: [
              Container(
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
                          sType = "";
                          sLevel = "";
                          sLanguage = "";
                          listLevelForRequest = results;
                          listLevelForRequest
                              .map((e) =>
                          sLevel = "${sLevel}${e.levelId},")
                              .toList();
                          listCategoryForRequest
                              .map((e) =>
                          sType = "${sType}${e.categoryId},")
                              .toList();
                          listLanguageForRequest
                              .map((e) => sLanguage =
                          "${sLanguage}${e.languageId},")
                              .toList();
                          BlocProvider.of<ParagraphsBloc>(context).add(
                              GetMyParagraphsEvent(
                                  pageId: "1",
                                  languageId: sLanguage,
                                  categoryId: sType,
                                  paragraphLevelId: sLevel));
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
                          sType = "";
                          sLevel = "";
                          sLanguage = "";
                          listLanguageForRequest = results;
                          listLevelForRequest
                              .map((e) =>
                          sLevel = "${sLevel}${e.levelId},")
                              .toList();
                          listCategoryForRequest
                              .map((e) =>
                          sType = "${sType}${e.categoryId},")
                              .toList();
                          listLanguageForRequest
                              .map((e) => sLanguage =
                          "${sLanguage}${e.languageId},")
                              .toList();
                          BlocProvider.of<ParagraphsBloc>(context).add(
                              GetMyParagraphsEvent(
                                  pageId: "1",
                                  languageId: sLanguage,
                                  categoryId: sType,
                                  paragraphLevelId: sLevel));
                        });
                      },
                    ),

                    SizedBox(
                      height: 20.h,
                    ),
                    MultiSelectDialogField(
                      initialValue: type,
                      dialogHeight: 250.h,
                      dialogWidth: 250.w,
                      items: itemsType,
                      title: Text(
                        "Categories",
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
                        "Categories",
                        style: TextStyle(
                          color: Colors.blue[800],
                          fontSize: 25.sp,
                        ),
                      ),
                      onConfirm: (results) {
                        setState(() {
                          sType = "";
                          sLevel = "";
                          sLanguage = "";
                          listCategoryForRequest = results;
                          listLevelForRequest
                              .map((e) =>
                          sLevel = "${sLevel}${e.levelId},")
                              .toList();
                          listCategoryForRequest
                              .map((e) =>
                          sType = "${sType}${e.categoryId},")
                              .toList();
                          listLanguageForRequest
                              .map((e) => sLanguage =
                          "${sLanguage}${e.languageId},")
                              .toList();
                          BlocProvider.of<ParagraphsBloc>(context).add(
                              GetMyParagraphsEvent(
                                  pageId: "1",
                                  languageId: sLanguage,
                                  categoryId: sType,
                                  paragraphLevelId: sLevel));
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
                    SizedBox(height: 20.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                      if(isTeacher)
                        SizedBox(
                          width: 250.w,
                          child: MyElevatedButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddStoryParagraph()));
                          }, child: Text("Add Paragraphs",style: TextStyle(color: Colors.white,fontSize: 25.sp),)),
                        ),
                    ],),
                    SizedBox(height: 20.h,),
                    Column(
                      children: List.generate(_paragraphsEntity.length, (index) {
                        return Column(
                          children: [
                            Container(
                              width: 900.w,
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UpdateStoryParagraph(
                                                              paragraphId:
                                                                  _paragraphsEntity[
                                                                          index]
                                                                      .paragraphId)));
                                            },
                                            icon: Icon(
                                              Icons.edit,
                                              size: 30.w,
                                            )),
                                        IconButton(
                                            onPressed: () {
                                              BlocProvider.of<ParagraphsBloc>(context).add(DeleteParagraphEvent(paragraphId: _paragraphsEntity[index].paragraphId));
                                              BlocProvider.of<ParagraphsBloc>(context).add(GetMyParagraphsEvent(pageId: "1", languageId: sLanguage, categoryId: sType, paragraphLevelId: sLevel));

                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              size: 30.w,
                                            ))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.h, horizontal: 40.w),
                                      child: Text(
                                        _paragraphsEntity[index].paragraphName,
                                        style: TextStyle(
                                            fontSize: 25.sp, color: Colors.black),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            )
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
                                  color: Colors.black,
                                  fontSize: 25.sp),
                            ),
                          )),
                    if (pagesPage.currentPage != "0")
                      BlocBuilder<ParagraphsBloc, ParagraphsState>(
                        builder: (context, state) {
                          if (state is GetMyParagraphsSuccess) {
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
                                        BlocProvider.of<
                                            ParagraphsBloc>(
                                            context)
                                            .add(GetMyParagraphsEvent(
                                            languageId:
                                            sLanguage,
                                            pageId:
                                            "${int.parse(pagesPage.currentPage) - 1}",
                                            categoryId: sType,
                                            paragraphLevelId:
                                            sLevel));
                                      }
                                    },
                                    child: Container(
                                      height: 60.h,
                                      width: 60.w,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black38),
                                        borderRadius:
                                        BorderRadius.only(
                                          topLeft:
                                          Radius.circular(8.w),
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
                                          int.parse(
                                              pagesPage
                                                  .lastPage)
                                          ? Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              BlocProvider.of<ParagraphsBloc>(context).add(GetMyParagraphsEvent(
                                                  languageId:
                                                  sLanguage,
                                                  pageId:
                                                  "${int.parse(pagesPage.currentPage) - 4}",
                                                  categoryId:
                                                  sType,
                                                  paragraphLevelId:
                                                  sLevel));
                                            },
                                            child:
                                            Container(
                                              alignment:
                                              Alignment
                                                  .center,
                                              height:
                                              60.h,
                                              width:
                                              60.w,
                                              padding:
                                              const EdgeInsets.symmetric(horizontal: 10)
                                                  .w,
                                              decoration:
                                              BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                    Colors.black38),
                                                color: Colors
                                                    .white,
                                              ),
                                              child: Text(
                                                  "${int.parse(pagesPage.currentPage) - 4}"),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              BlocProvider.of<ParagraphsBloc>(context).add(GetMyParagraphsEvent(
                                                  languageId:
                                                  sLanguage,
                                                  pageId:
                                                  "${int.parse(pagesPage.currentPage) - 3}",
                                                  categoryId:
                                                  sType,
                                                  paragraphLevelId:
                                                  sLevel));
                                            },
                                            child:
                                            Container(
                                              alignment:
                                              Alignment
                                                  .center,
                                              height:
                                              60.h,
                                              width:
                                              60.w,
                                              padding:
                                              const EdgeInsets.symmetric(horizontal: 10)
                                                  .w,
                                              decoration:
                                              BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                    Colors.black38),
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
                                          BlocProvider.of<ParagraphsBloc>(context).add(GetMyParagraphsEvent(
                                              languageId:
                                              sLanguage,
                                              pageId:
                                              "${int.parse(pagesPage.currentPage) - 3}",
                                              categoryId:
                                              sType,
                                              paragraphLevelId:
                                              sLevel));
                                        },
                                        child:
                                        Container(
                                          alignment:
                                          Alignment
                                              .center,
                                          height:
                                          60.h,
                                          width:
                                          60.w,
                                          padding:
                                          const EdgeInsets.symmetric(horizontal: 10)
                                              .w,
                                          decoration:
                                          BoxDecoration(
                                            border: Border.all(
                                                color:
                                                Colors.black38),
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
                                          BlocProvider.of<ParagraphsBloc>(context).add(GetMyParagraphsEvent(
                                              languageId:
                                              sLanguage,
                                              pageId:
                                              "${int.parse(pagesPage.currentPage) - 2}",
                                              categoryId:
                                              sType,
                                              paragraphLevelId:
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
                                          BlocProvider.of<ParagraphsBloc>(context).add(GetMyParagraphsEvent(
                                              languageId:
                                              sLanguage,
                                              pageId:
                                              "${int.parse(pagesPage.currentPage) - 1}",
                                              categoryId:
                                              sType,
                                              paragraphLevelId:
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
                                              "${int.parse(pagesPage.currentPage) - 1}"),
                                        ),
                                      )
                                          : Container(),
                                      Container(
                                        alignment:
                                        Alignment.center,
                                        height: 70.h,
                                        width: 70.w,
                                        decoration:
                                        BoxDecoration(
                                          border: Border.all(
                                              color: Colors
                                                  .black38),
                                          color: Colors.white,
                                        ),
                                        child: Text(
                                          "${int.parse(pagesPage.currentPage)}",
                                          style: TextStyle(
                                              color: Colors
                                                  .blue
                                                  .shade300),
                                        ),
                                      ),
                                      int.parse(pagesPage
                                          .currentPage) +
                                          1 <=
                                          int.parse(
                                              pagesPage
                                                  .lastPage)
                                          ? InkWell(
                                        onTap: () {
                                          BlocProvider.of<ParagraphsBloc>(context).add(GetMyParagraphsEvent(
                                              languageId:
                                              sLanguage,
                                              pageId:
                                              "${int.parse(pagesPage.currentPage) + 1}",
                                              categoryId:
                                              sType,
                                              paragraphLevelId:
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
                                              "${int.parse(pagesPage.currentPage) + 1}"),
                                        ),
                                      )
                                          : Container(),
                                      int.parse(pagesPage
                                          .currentPage) +
                                          2 <=
                                          int.parse(
                                              pagesPage
                                                  .lastPage)
                                          ? InkWell(
                                        onTap: () {
                                          BlocProvider.of<ParagraphsBloc>(context).add(GetMyParagraphsEvent(
                                              languageId:
                                              sLanguage,
                                              pageId:
                                              "${int.parse(pagesPage.currentPage) + 2}",
                                              categoryId:
                                              sType,
                                              paragraphLevelId:
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
                                              BlocProvider.of<ParagraphsBloc>(context).add(GetMyParagraphsEvent(
                                                  languageId:
                                                  sLanguage,
                                                  pageId:
                                                  "${int.parse(pagesPage.currentPage) + 3}",
                                                  categoryId:
                                                  sType,
                                                  paragraphLevelId:
                                                  sLevel));
                                            },
                                            child:
                                            Container(
                                              alignment:
                                              Alignment
                                                  .center,
                                              height:
                                              60.h,
                                              width:
                                              60.w,
                                              padding:
                                              const EdgeInsets.symmetric(horizontal: 10)
                                                  .w,
                                              decoration:
                                              BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                    Colors.black38),
                                                color: Colors
                                                    .white,
                                              ),
                                              child: Text(
                                                  "${int.parse(pagesPage.currentPage) + 3}"),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              BlocProvider.of<ParagraphsBloc>(context).add(GetMyParagraphsEvent(
                                                  languageId:
                                                  sLanguage,
                                                  pageId:
                                                  "${int.parse(pagesPage.currentPage) + 4}",
                                                  categoryId:
                                                  sType,
                                                  paragraphLevelId:
                                                  sLevel));
                                            },
                                            child:
                                            Container(
                                              alignment:
                                              Alignment
                                                  .center,
                                              height:
                                              60.h,
                                              width:
                                              60.w,
                                              padding:
                                              const EdgeInsets.symmetric(horizontal: 10)
                                                  .w,
                                              decoration:
                                              BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                    Colors.black38),
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
                                          BlocProvider.of<ParagraphsBloc>(context).add(GetMyParagraphsEvent(
                                              languageId:
                                              sLanguage,
                                              pageId:
                                              "${int.parse(pagesPage.currentPage) + 3}",
                                              categoryId:
                                              sType,
                                              paragraphLevelId:
                                              sLevel));
                                        },
                                        child:
                                        Container(
                                          alignment:
                                          Alignment
                                              .center,
                                          height:
                                          60.h,
                                          width:
                                          60.w,
                                          padding:
                                          const EdgeInsets.symmetric(horizontal: 10)
                                              .w,
                                          decoration:
                                          BoxDecoration(
                                            border: Border.all(
                                                color:
                                                Colors.black38),
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
                                                ParagraphsBloc>(
                                                context)
                                                .add(GetMyParagraphsEvent(
                                                languageId:
                                                sLanguage,
                                                pageId: i
                                                    .toString(),
                                                categoryId:
                                                sType,
                                                paragraphLevelId:
                                                sLevel));
                                          },
                                          child: Container(
                                            alignment:
                                            Alignment
                                                .center,
                                            height: int.parse(
                                                pagesPage
                                                    .currentPage) ==
                                                i
                                                ? 70.h
                                                : 60.h,
                                            width: int.parse(
                                                pagesPage
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
                                              color: Colors
                                                  .white,
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
                                        BlocProvider.of<
                                            ParagraphsBloc>(
                                            context)
                                            .add(GetMyParagraphsEvent(
                                            languageId:
                                            sLanguage,
                                            pageId:
                                            "${int.parse(pagesPage.currentPage) + 1}",
                                            categoryId: sType,
                                            paragraphLevelId:
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
                                        borderRadius:
                                        BorderRadius.only(
                                          topRight:
                                          Radius.circular(8.w),
                                          bottomRight:
                                          Radius.circular(8.w),
                                        ),
                                        color: int.parse(pagesPage
                                            .currentPage) ==
                                            int.parse(pagesPage
                                                .lastPage)
                                            ? Colors.black12
                                            : Colors.white,
                                      ),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: int.parse(pagesPage
                                            .currentPage) ==
                                            int.parse(pagesPage
                                                .lastPage)
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
      } else if (state is GetAllParagraphsError) {
        return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0).w,
              child: Row(
                children: [
                  Container(
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
                              sType = "";
                              sLevel = "";
                              sLanguage = "";
                              listLevelForRequest = results;
                              listLevelForRequest
                                  .map((e) =>
                              sLevel = "${sLevel}${e.levelId},")
                                  .toList();
                              listCategoryForRequest
                                  .map((e) =>
                              sType = "${sType}${e.categoryId},")
                                  .toList();
                              listLanguageForRequest
                                  .map((e) => sLanguage =
                              "${sLanguage}${e.languageId},")
                                  .toList();
                              BlocProvider.of<ParagraphsBloc>(context).add(
                                  GetMyParagraphsEvent(
                                      pageId: "1",
                                      languageId: sLanguage,
                                      categoryId: sType,
                                      paragraphLevelId: sLevel));
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
                              sType = "";
                              sLevel = "";
                              sLanguage = "";
                              listLanguageForRequest = results;
                              listLevelForRequest
                                  .map((e) =>
                              sLevel = "${sLevel}${e.levelId},")
                                  .toList();
                              listCategoryForRequest
                                  .map((e) =>
                              sType = "${sType}${e.categoryId},")
                                  .toList();
                              listLanguageForRequest
                                  .map((e) => sLanguage =
                              "${sLanguage}${e.languageId},")
                                  .toList();
                              BlocProvider.of<ParagraphsBloc>(context).add(
                                  GetMyParagraphsEvent(
                                      pageId: "1",
                                      languageId: sLanguage,
                                      categoryId: sType,
                                      paragraphLevelId: sLevel));
                            });
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        MultiSelectDialogField(
                          initialValue: type,
                          dialogHeight: 250.h,
                          dialogWidth: 250.w,
                          items: itemsType,
                          title: Text(
                            "Categories",
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
                            "Categories",
                            style: TextStyle(
                              color: Colors.blue[800],
                              fontSize: 25.sp,
                            ),
                          ),
                          onConfirm: (results) {
                            setState(() {
                              sType = "";
                              sLevel = "";
                              sLanguage = "";
                              listCategoryForRequest = results;
                              listLevelForRequest
                                  .map((e) =>
                              sLevel = "${sLevel}${e.levelId},")
                                  .toList();
                              listCategoryForRequest
                                  .map((e) =>
                              sType = "${sType}${e.categoryId},")
                                  .toList();
                              listLanguageForRequest
                                  .map((e) => sLanguage =
                              "${sLanguage}${e.languageId},")
                                  .toList();
                              BlocProvider.of<ParagraphsBloc>(context).add(
                                  GetMyParagraphsEvent(
                                      pageId: "1",
                                      languageId: sLanguage,
                                      categoryId: sType,
                                      paragraphLevelId: sLevel));
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
                        "There are not any paragraphs.",
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
                  Container(
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
                              sType = "";
                              sLevel = "";
                              sLanguage = "";
                              listLevelForRequest = results;
                              listLevelForRequest
                                  .map((e) =>
                              sLevel = "${sLevel}${e.levelId},")
                                  .toList();
                              listCategoryForRequest
                                  .map((e) =>
                              sType = "${sType}${e.categoryId},")
                                  .toList();
                              listLanguageForRequest
                                  .map((e) => sLanguage =
                              "${sLanguage}${e.languageId},")
                                  .toList();
                              BlocProvider.of<ParagraphsBloc>(context)
                                  .add(GetMyParagraphsEvent(
                                  pageId: "1",
                                  languageId: sLanguage,
                                  categoryId: sType,
                                  paragraphLevelId: sLevel));
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
                              sType = "";
                              sLevel = "";
                              sLanguage = "";
                              listLanguageForRequest = results;
                              listLevelForRequest
                                  .map((e) =>
                              sLevel = "${sLevel}${e.levelId},")
                                  .toList();
                              listCategoryForRequest
                                  .map((e) =>
                              sType = "${sType}${e.categoryId},")
                                  .toList();
                              listLanguageForRequest
                                  .map((e) => sLanguage =
                              "${sLanguage}${e.languageId},")
                                  .toList();
                              BlocProvider.of<ParagraphsBloc>(context)
                                  .add(GetMyParagraphsEvent(
                                  pageId: "1",
                                  languageId: sLanguage,
                                  categoryId: sType,
                                  paragraphLevelId: sLevel));
                            });
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        MultiSelectDialogField(
                          initialValue: type,
                          dialogHeight: 250.h,
                          dialogWidth: 250.w,
                          items: itemsType,
                          title: Text(
                            "Categories",
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
                            "Categories",
                            style: TextStyle(
                              color: Colors.blue[800],
                              fontSize: 25.sp,
                            ),
                          ),
                          onConfirm: (results) {
                            setState(() {
                              sType = "";
                              sLevel = "";
                              sLanguage = "";
                              listCategoryForRequest = results;
                              listLevelForRequest
                                  .map((e) =>
                              sLevel = "${sLevel}${e.levelId},")
                                  .toList();
                              listCategoryForRequest
                                  .map((e) =>
                              sType = "${sType}${e.categoryId},")
                                  .toList();
                              listLanguageForRequest
                                  .map((e) => sLanguage =
                              "${sLanguage}${e.languageId},")
                                  .toList();
                              BlocProvider.of<ParagraphsBloc>(context)
                                  .add(GetMyParagraphsEvent(
                                  pageId: "1",
                                  languageId: sLanguage,
                                  categoryId: sType,
                                  paragraphLevelId: sLevel));
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
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    ),
                  )
                ])));
      }
  },
),
    );
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

class TypeStoriesParagraphs {
  final int id;
  final String name;

  TypeStoriesParagraphs({
    required this.id,
    required this.name,
  });
}
