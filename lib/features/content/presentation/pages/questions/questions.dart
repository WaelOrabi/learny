import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learny_project/features/admin/presentation/bloc/language_bloc/language_bloc.dart';
import 'package:learny_project/features/auth/data/models/user_model.dart';
import 'package:learny_project/features/auth/presentation/widgets/ElvatedButtonWdget.dart';
import 'package:learny_project/features/content/domain/entities/category_question.dart';
import 'package:learny_project/features/content/domain/entities/options_question_entity.dart';
import 'package:learny_project/features/content/presentation/bloc/content/content_bloc.dart';
import 'package:learny_project/features/content/presentation/bloc/questions/questions_bloc.dart';
import 'package:learny_project/features/content/presentation/pages/questions/add_questions.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import 'package:learny_project/injection_container.dart' as di;
import '../../../../../core/error/exception.dart';
import '../../../../admin/domain/entities/language_entity.dart';
import '../../../../auth/data/datasources/local_data_sources/auth_local_data_sources.dart';
import '../../../domain/entities/level_content.dart';
import '../../../domain/entities/questions_entity.dart';
import 'my_questions.dart';

class Questions extends StatefulWidget {
  const Questions({Key? key}) : super(key: key);

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  @override
  void initState() {
    BlocProvider.of<LanguageBloc>(context).add(GetAllLanguagesEvent());
    BlocProvider.of<ContentBloc>(context).add(GetLevelsContentEvent());
    BlocProvider.of<ContentBloc>(context).add(GetCategoriesQuestionEvent());
    BlocProvider.of<QuestionsBloc>(context).add(GetAllQuestionsEvent(
        pageId: "1", languageId: "1,2,3,4", categoryId: "1,2,3,4", questionLevelId: "1,2,3,4"));
    _getUserInformation();
    super.initState();
  }
  final AuthLocalDataSources _authLocalDataSourcesImpl =
  di.sl<AuthLocalDataSources>();


  bool isTeacher = false;
  List<LevelContentEntity> listLevelForRequest = [
    LevelContentEntity(levelId: "1", levelName: "")
  ];
  String sLevel = "";
  List<CategoryQuestionEntity> listCategoryForRequest = [
    CategoryQuestionEntity(categoryId: "1", categoryName: "", languageId: "")
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
  late List<MultiSelectItem<CategoryQuestionEntity>> itemsType = [
    MultiSelectItem<CategoryQuestionEntity>(
        CategoryQuestionEntity(
            categoryId: "", categoryName: "", languageId: ""),
        "")
  ];
  List<Language> language = [Language(languageId: "1", languageName: "")];
  late List<MultiSelectItem<Language>> itemsLanguage = [
    MultiSelectItem<Language>(Language(languageId: "", languageName: ""), "")
  ];

  List<LevelContentEntity> level = [
    LevelContentEntity(levelId: "1", levelName: "")
  ];
  List<CategoryQuestionEntity> type = [
    CategoryQuestionEntity(categoryId: "1", categoryName: "", languageId: "")
  ];

  List<HelperQuestions> _isAnswered = [];
  late List<QuestionsEntity> _questionsEntity = [];
  late PagesPage pagesPage;
UserModel? userInformation;
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
          if (state is GetCategoriesQuestionSuccess) {
            type = state.listCategoryQuestionEntity;
            listCategoryForRequest = type;
            setState(() {});
            itemsType = type
                .where((element) => element.languageId == "1")
                .map((e) =>
                    MultiSelectItem<CategoryQuestionEntity>(e, e.categoryName))
                .toList();
          }
        }),
        BlocListener<ContentBloc, ContentState>(listener: (context, state) {
          if (state is GetLevelsContentSuccess) {
            level = state.listLevelContentEntity;
            listLevelForRequest = level;
            itemsLevel = level
                .map((e) => MultiSelectItem<LevelContentEntity>(e, e.levelName))
                .toList();
          }
        }),
      ],
      child: BlocBuilder<QuestionsBloc, QuestionsState>(
        builder: (context, state) {
          if (state is GetAllQuestionsSuccess) {
            pagesPage = state.listQuestions.pages;
            _questionsEntity = state.listQuestions.questionsEntity;
            return SafeArea(
                child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                toolbarHeight: 100.h,
                elevation: 0.2,
                backgroundColor: Theme.of(context).primaryColor,
                title: Center(
                    child: Text(
                  "Questions",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 35.sp),
                )),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0).w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                BlocProvider.of<QuestionsBloc>(context).add(
                                    GetAllQuestionsEvent(
                                        pageId: "1",
                                        languageId: sLanguage,
                                        categoryId: sType,
                                        questionLevelId: sLevel));
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
                                BlocProvider.of<QuestionsBloc>(context).add(
                                    GetAllQuestionsEvent(
                                        pageId: "1",
                                        languageId: sLanguage,
                                        categoryId: sType,
                                        questionLevelId: sLevel));
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
                                BlocProvider.of<QuestionsBloc>(context).add(
                                    GetAllQuestionsEvent(
                                        pageId: "1",
                                        languageId: sLanguage,
                                        categoryId: sType,
                                        questionLevelId: sLevel));
                              });
                            },
                          ),

                        ],
                      ),
                    ),
                    SizedBox(
                      width: 30.w,
                    ),
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if(isTeacher)
                          SizedBox(height: 20.h,),
                          Row(children: [
                            if(isTeacher)
                              SizedBox(
                                width: 20.h,
                              ),
                            if(isTeacher)
                              SizedBox(
                                width: 250.w,
                                child: MyElevatedButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyQuestions()));
                                }, child: Text("My Questions",style: TextStyle(color: Colors.white,fontSize: 25.sp),)),
                              ),
                            if(isTeacher)
                              SizedBox(
                                width: 20.h,
                              ),
                            if(isTeacher)
                              SizedBox(
                                width: 250.w,
                                child: MyElevatedButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddQuestions()));
                                }, child: Text("Add Questions",style: TextStyle(color: Colors.white,fontSize: 25.sp),)),
                              ),


                          ],),
                          if(isTeacher)
                            SizedBox(height: 20.h,),
                          Column(
                            children:
                                List.generate(_questionsEntity.length, (index) {
                              _isAnswered.add(HelperQuestions(
                                  id: int.parse(
                                      _questionsEntity[index].questionId),
                                  isAnswered: false));
                              return Column(
                                children: [
                                  Container(
                                    width: 800.w,
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0).w,
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 30.w,
                                                      backgroundImage: _questionsEntity[
                                                                      index]
                                                                  .profileImageTeacher ==
                                                              null
                                                          ? const NetworkImage(
                                                              "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/925px-Unknown_person.jpg")
                                                          : NetworkImage(
                                                              "${_questionsEntity[index].profileImageTeacher}"),
                                                    ),
                                                    SizedBox(
                                                      width: 20.w,
                                                    ),
                                                    Text(
                                                      "${_questionsEntity[index].firstNameTeacher} ${_questionsEntity[index].lastNameTeacher}",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 25.sp,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    BlocProvider.of<
                                                                ContentBloc>(
                                                            context)
                                                        .add(FollowOrUnFollowEvent(
                                                            teacherId:
                                                                _questionsEntity[
                                                                        index]
                                                                    .teacherId));
                                                    BlocProvider.of<
                                                                QuestionsBloc>(
                                                            context)
                                                        .add(
                                                            GetAllQuestionsEvent(
                                                                pageId: "1",
                                                                languageId:
                                                                    sLanguage,
                                                                categoryId:
                                                                    sType,
                                                                questionLevelId:
                                                                    sLevel));
                                                  },
                                                  child: _questionsEntity[index]
                                                              .isFollowingTeacher ==
                                                          false
                                                      ? Text(
                                                          "Follow",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              fontSize: 25.sp),
                                                        )
                                                      : Text(
                                                          "Following",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 25.sp),
                                                        ))
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 60)
                                                    .w,
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Q${index + 1}: ",
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 25.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  _questionsEntity[index]
                                                      .questionName,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 25.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 60)
                                                    .w,
                                            child: Text(
                                              "A: ",
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 25.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                      left: 80)
                                                  .w,
                                              child: Column(
                                                children: List.generate(
                                                    _questionsEntity[index]
                                                        .optionsList
                                                        .length, (index1) {
                                                  return Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "${index1 + 1}) ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        25.sp),
                                                              ),
                                                              Text(
                                                                _questionsEntity[
                                                                        index]
                                                                    .optionsList[
                                                                        index1]
                                                                    .optionName,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        25.sp),
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            children: [
                                                              IconButton(
                                                                onPressed: _isAnswered[index].isAnswered ==
                                                                            true ||
                                                                        _questionsEntity[index].isSolve ==
                                                                            true
                                                                    ? null
                                                                    : () {
                                                                        setState(
                                                                            () {
                                                                          _isAnswered[index].isAnswered =
                                                                              true;
                                                                          _isAnswered[index].id =
                                                                              index1;
                                                                          if (_questionsEntity[index].optionsList[index1].isTrue ==
                                                                              true)
                                                                            BlocProvider.of<ContentBloc>(context).add(SolveQuestionEvent(
                                                                                questionId: _questionsEntity[index].questionId,
                                                                                answerId: _questionsEntity[index].optionsList[index1].optionId));
                                                                        });
                                                                      },
                                                                icon: _questionsEntity[index].optionsList[index1].isTrue ==
                                                                            true &&
                                                                        _questionsEntity[index]
                                                                            .isSolve
                                                                    ? Icon(
                                                                        Icons
                                                                            .check,
                                                                        color: Colors
                                                                            .green,
                                                                        size: 30
                                                                            .w,
                                                                      )
                                                                    : _isAnswered[index].id !=
                                                                            index1
                                                                        ? Icon(
                                                                            Icons.radio_button_off,
                                                                            size:
                                                                                30.w,
                                                                          )
                                                                        : _questionsEntity[index].optionsList[index1].isTrue ==
                                                                                true
                                                                            ? Icon(
                                                                                Icons.check,
                                                                                color: Colors.green,
                                                                                size: 30.w,
                                                                              )
                                                                            : Icon(
                                                                                Icons.do_not_disturb_alt,
                                                                                color: Colors.red,
                                                                                size: 30.w,
                                                                              ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      if (_questionsEntity[
                                                                      index]
                                                                  .descriptionAnswer !=
                                                              null &&
                                                          _isAnswered[index]
                                                              .isAnswered &&
                                                          _questionsEntity[
                                                                  index]
                                                              .optionsList[
                                                                  index1]
                                                              .isTrue &&
                                                          _isAnswered[index]
                                                                  .id ==
                                                              index1)
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Description: ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .green,
                                                                  fontSize:
                                                                      20.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              "${_questionsEntity[index].descriptionAnswer}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      20.sp),
                                                            )
                                                          ],
                                                        )
                                                    ],
                                                  );
                                                }),
                                              ))
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
                            height: 30.h,
                          ),
                          if (pagesPage.currentPage == "0")
                            Padding(
                                padding: EdgeInsets.only(left: 300.w),
                                child: Center(
                                  child: Text(
                                    "There are not any question,try with other Filter",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 25.sp),
                                  ),
                                )),
                          if (pagesPage.currentPage != "0")
                            BlocBuilder<QuestionsBloc, QuestionsState>(
                              builder: (context, state) {
                                if (state is GetAllQuestionsSuccess) {
                                  return IntrinsicHeight(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (int.parse(
                                                        pagesPage.currentPage) -
                                                    1 !=
                                                0) {
                                              BlocProvider.of<QuestionsBloc>(
                                                      context)
                                                  .add(GetAllQuestionsEvent(
                                                      languageId: sLanguage,
                                                      pageId:
                                                          "${int.parse(pagesPage.currentPage) - 1}",
                                                      categoryId: sType,
                                                      questionLevelId: sLevel));
                                              _isAnswered = [];
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
                                                                BlocProvider.of<QuestionsBloc>(context).add(GetAllQuestionsEvent(
                                                                    languageId:
                                                                        sLanguage,
                                                                    pageId:
                                                                        "${int.parse(pagesPage.currentPage) - 4}",
                                                                    categoryId:
                                                                        sType,
                                                                    questionLevelId:
                                                                        sLevel));
                                                                _isAnswered =
                                                                    [];
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
                                                                    "${int.parse(pagesPage.currentPage) - 4}"),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                BlocProvider.of<QuestionsBloc>(context).add(GetAllQuestionsEvent(
                                                                    languageId:
                                                                        sLanguage,
                                                                    pageId:
                                                                        "${int.parse(pagesPage.currentPage) - 3}",
                                                                    categoryId:
                                                                        sType,
                                                                    questionLevelId:
                                                                        sLevel));
                                                                _isAnswered =
                                                                    [];
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
                                                                BlocProvider.of<QuestionsBloc>(context).add(GetAllQuestionsEvent(
                                                                    languageId:
                                                                        sLanguage,
                                                                    pageId:
                                                                        "${int.parse(pagesPage.currentPage) - 3}",
                                                                    categoryId:
                                                                        sType,
                                                                    questionLevelId:
                                                                        sLevel));
                                                                _isAnswered =
                                                                    [];
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
                                                                        QuestionsBloc>(
                                                                    context)
                                                                .add(GetAllQuestionsEvent(
                                                                    languageId:
                                                                        sLanguage,
                                                                    pageId:
                                                                        "${int.parse(pagesPage.currentPage) - 2}",
                                                                    categoryId:
                                                                        sType,
                                                                    questionLevelId:
                                                                        sLevel));
                                                            _isAnswered = [];
                                                          },
                                                          child: Container(
                                                            alignment: Alignment
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
                                                              color:
                                                                  Colors.white,
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
                                                                        QuestionsBloc>(
                                                                    context)
                                                                .add(GetAllQuestionsEvent(
                                                                    languageId:
                                                                        sLanguage,
                                                                    pageId:
                                                                        "${int.parse(pagesPage.currentPage) - 1}",
                                                                    categoryId:
                                                                        sType,
                                                                    questionLevelId:
                                                                        sLevel));
                                                            _isAnswered = [];
                                                          },
                                                          child: Container(
                                                            alignment: Alignment
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
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            child: Text(
                                                                "${int.parse(pagesPage.currentPage) - 1}"),
                                                          ),
                                                        )
                                                      : Container(),
                                                  Container(
                                                    alignment: Alignment.center,
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
                                                                        QuestionsBloc>(
                                                                    context)
                                                                .add(GetAllQuestionsEvent(
                                                                    languageId:
                                                                        sLanguage,
                                                                    pageId:
                                                                        "${int.parse(pagesPage.currentPage) + 1}",
                                                                    categoryId:
                                                                        sType,
                                                                    questionLevelId:
                                                                        sLevel));
                                                            _isAnswered = [];
                                                          },
                                                          child: Container(
                                                            alignment: Alignment
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
                                                              color:
                                                                  Colors.white,
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
                                                                        QuestionsBloc>(
                                                                    context)
                                                                .add(GetAllQuestionsEvent(
                                                                    languageId:
                                                                        sLanguage,
                                                                    pageId:
                                                                        "${int.parse(pagesPage.currentPage) + 2}",
                                                                    categoryId:
                                                                        sType,
                                                                    questionLevelId:
                                                                        sLevel));
                                                            _isAnswered = [];
                                                          },
                                                          child: Container(
                                                            alignment: Alignment
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
                                                              color:
                                                                  Colors.white,
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
                                                                BlocProvider.of<QuestionsBloc>(context).add(GetAllQuestionsEvent(
                                                                    languageId:
                                                                        sLanguage,
                                                                    pageId:
                                                                        "${int.parse(pagesPage.currentPage) + 3}",
                                                                    categoryId:
                                                                        sType,
                                                                    questionLevelId:
                                                                        sLevel));
                                                                _isAnswered =
                                                                    [];
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
                                                                    "${int.parse(pagesPage.currentPage) + 3}"),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                BlocProvider.of<QuestionsBloc>(context).add(GetAllQuestionsEvent(
                                                                    languageId:
                                                                        sLanguage,
                                                                    pageId:
                                                                        "${int.parse(pagesPage.currentPage) + 4}",
                                                                    categoryId:
                                                                        sType,
                                                                    questionLevelId:
                                                                        sLevel));
                                                                _isAnswered =
                                                                    [];
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
                                                                BlocProvider.of<QuestionsBloc>(context).add(GetAllQuestionsEvent(
                                                                    languageId:
                                                                        sLanguage,
                                                                    pageId:
                                                                        "${int.parse(pagesPage.currentPage) + 3}",
                                                                    categoryId:
                                                                        sType,
                                                                    questionLevelId:
                                                                        sLevel));
                                                                _isAnswered =
                                                                    [];
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
                                                                    QuestionsBloc>(
                                                                context)
                                                            .add(GetAllQuestionsEvent(
                                                                languageId:
                                                                    sLanguage,
                                                                pageId: i
                                                                    .toString(),
                                                                categoryId:
                                                                    sType,
                                                                questionLevelId:
                                                                    sLevel));
                                                        _isAnswered = [];
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: int.parse(pagesPage
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
                                                                horizontal: 10)
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
                                            if (int.parse(
                                                        pagesPage.currentPage) +
                                                    1 <=
                                                int.parse(pagesPage.lastPage)) {
                                              BlocProvider.of<QuestionsBloc>(
                                                      context)
                                                  .add(GetAllQuestionsEvent(
                                                      languageId: sLanguage,
                                                      pageId:
                                                          "${int.parse(pagesPage.currentPage) + 1}",
                                                      categoryId: sType,
                                                      questionLevelId: sLevel));
                                              _isAnswered = [];
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
                                                topRight: Radius.circular(8.w),
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
                    ),
                    SizedBox(width: 50.w,)
                  ],
                ),
              ),
            ));
          } else if (state is GetAllQuestionsError) {
            return SafeArea(
                child: Scaffold(
                    appBar: AppBar(
                      centerTitle: true,
                      toolbarHeight: 100.h,
                      elevation: 0.2,
                      backgroundColor: Theme.of(context).primaryColor,
                      title: Center(
                          child: Text(
                        "Questions",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 35.sp),
                      )),
                    ),
                    body: Padding(
                        padding: const EdgeInsets.all(20.0).w,
                        child: Row(children: [
                          SizedBox(
                            width: 250.w,
                            height: double.infinity,
                            child: SingleChildScrollView(
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
                                            .map((e) => sType =
                                                "${sType}${e.categoryId},")
                                            .toList();
                                        listLanguageForRequest
                                            .map((e) => sLanguage =
                                                "${sLanguage}${e.languageId},")
                                            .toList();
                                        BlocProvider.of<QuestionsBloc>(context)
                                            .add(GetAllQuestionsEvent(
                                                pageId: "1",
                                                languageId: sLanguage,
                                                categoryId: sType,
                                                questionLevelId: sLevel));
                                        _isAnswered = [];
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
                                            .map((e) => sType =
                                                "${sType}${e.categoryId},")
                                            .toList();
                                        listLanguageForRequest
                                            .map((e) => sLanguage =
                                                "${sLanguage}${e.languageId},")
                                            .toList();
                                        BlocProvider.of<QuestionsBloc>(context)
                                            .add(GetAllQuestionsEvent(
                                                pageId: "1",
                                                languageId: sLanguage,
                                                categoryId: sType,
                                                questionLevelId: sLevel));
                                        _isAnswered = [];
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
                                            .map((e) => sType =
                                                "${sType}${e.categoryId},")
                                            .toList();
                                        listLanguageForRequest
                                            .map((e) => sLanguage =
                                                "${sLanguage}${e.languageId},")
                                            .toList();
                                        BlocProvider.of<QuestionsBloc>(context)
                                            .add(GetAllQuestionsEvent(
                                                pageId: "1",
                                                languageId: sLanguage,
                                                categoryId: sType,
                                                questionLevelId: sLevel));
                                        _isAnswered = [];
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 200.w,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 30.w),
                            child: Center(
                              child: Text(
                                "There are not any Questions.",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 25.sp),
                              ),
                            ),
                          )
                        ]))));
          } else {
            return SafeArea(
                child: Scaffold(
                    appBar: AppBar(
                      centerTitle: true,
                      toolbarHeight: 100.h,
                      elevation: 0.2,
                      backgroundColor: Theme.of(context).primaryColor,
                      title: Center(
                          child: Text(
                        "Questions",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 35.sp),
                      )),
                    ),
                    body: Padding(
                        padding: const EdgeInsets.all(20.0).w,
                        child: Row(children: [
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
                                          .map((e) => sType =
                                              "${sType}${e.categoryId},")
                                          .toList();
                                      listLanguageForRequest
                                          .map((e) => sLanguage =
                                              "${sLanguage}${e.languageId},")
                                          .toList();
                                      BlocProvider.of<QuestionsBloc>(context)
                                          .add(GetAllQuestionsEvent(
                                              pageId: "1",
                                              languageId: sLanguage,
                                              categoryId: sType,
                                              questionLevelId: sLevel));
                                      _isAnswered = [];
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
                                          .map((e) => sType =
                                              "${sType}${e.categoryId},")
                                          .toList();
                                      listLanguageForRequest
                                          .map((e) => sLanguage =
                                              "${sLanguage}${e.languageId},")
                                          .toList();
                                      BlocProvider.of<QuestionsBloc>(context)
                                          .add(GetAllQuestionsEvent(
                                              pageId: "1",
                                              languageId: sLanguage,
                                              categoryId: sType,
                                              questionLevelId: sLevel));
                                      _isAnswered = [];
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
                                          .map((e) => sType =
                                              "${sType}${e.categoryId},")
                                          .toList();
                                      listLanguageForRequest
                                          .map((e) => sLanguage =
                                              "${sLanguage}${e.languageId},")
                                          .toList();
                                      BlocProvider.of<QuestionsBloc>(context)
                                          .add(GetAllQuestionsEvent(
                                              pageId: "1",
                                              languageId: sLanguage,
                                              categoryId: sType,
                                              questionLevelId: sLevel));
                                      _isAnswered = [];
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
                        ]))));
          }
        },
      ),
    );
  }

  Future<void> _getUserInformation() async {
    try {
      userInformation = await _authLocalDataSourcesImpl.getCachedUser();
      setState(() {});
    } catch (error) {
      if (error is EmptyCacheException) {
        userInformation = null;
      }
    }
  }
}

class HelperQuestions {
  int id;
  bool isAnswered;

  HelperQuestions({
    required this.id,
    required this.isAnswered,
  });
}
