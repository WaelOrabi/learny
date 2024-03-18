import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learny_project/core/widgets/toast_widget.dart';
import 'package:learny_project/features/content/domain/entities/questions_entity.dart';
import 'package:learny_project/features/content/presentation/bloc/questions/questions_bloc.dart';
import 'package:learny_project/features/content/presentation/pages/questions/questions.dart';
import '../../../../admin/domain/entities/language_entity.dart';
import '../../../../admin/presentation/bloc/language_bloc/language_bloc.dart';
import '../../../../auth/presentation/widgets/ElvatedButtonWdget.dart';
import '../../../../teachers/presentation/widgets/becom_a_teacher_widgets/build_drop_down_button.dart';
import '../../../domain/entities/category_question.dart';
import '../../../domain/entities/level_content.dart';
import '../../../domain/entities/options_question_entity.dart';
import '../../bloc/content/content_bloc.dart';
import 'my_questions.dart';

class AddQuestions extends StatefulWidget {
  const AddQuestions({Key? key}) : super(key: key);

  @override
  State<AddQuestions> createState() => _AddQuestionsState();
}

class _AddQuestionsState extends State<AddQuestions> {
  @override
  void initState() {
    BlocProvider.of<LanguageBloc>(context).add(GetAllLanguagesEvent());
    BlocProvider.of<ContentBloc>(context).add(GetLevelsContentEvent());
    BlocProvider.of<ContentBloc>(context).add(GetCategoriesQuestionEvent());
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController questionNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController()
  ];
  List<String> listNumber = ["1", "2"];
  List<Language> language = [
    Language(languageId: "1", languageName: "English")
  ];

  List<LevelContentEntity> level = [
    LevelContentEntity(levelId: "1", levelName: "Easy")
  ];
  List<CategoryQuestionEntity> type = [
    CategoryQuestionEntity(
        categoryId: "1", categoryName: "Grammar", languageId: "1")
  ];

  String sLanguage = "English";
  String idLanguage = "1";
  String sType = "Grammar";
  String idType = "1";
  String sLevel = "Easy";
  String idLevel = "1";
  String indexTrue = "1";

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LanguageBloc, LanguageState>(listener: (context, state) {
          if (state is GetAllLanguagesSuccessState) {
            language = state.listAllLanguages;
            setState(() {});
          }
        }),
        BlocListener<ContentBloc, ContentState>(listener: (context, state) {
          if (state is GetCategoriesQuestionSuccess) {
            type = state.listCategoryQuestionEntity;
            setState(() {});
          }
        }),
        BlocListener<ContentBloc, ContentState>(listener: (context, state) {
          if (state is GetLevelsContentSuccess) {
            level = state.listLevelContentEntity;
            setState(() {});
          }
        }),
      ],
      child: Form(
        key: _formKey,
        child: SafeArea(
            child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.5,
            title: Text(
              "Add question",
              style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
          ),
          body: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0).w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Levels: ",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.sp),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      height: 50.h,
                      width: 300.w,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                      child: buildDropdownButton(
                          value: sLevel,
                          items: level.map((e) => e.levelName).toList(),
                          onChange: (String? newValue) {
                            setState(() {
                              sLevel = newValue!;
                              level.map((e) {
                                if (e.levelName == newValue) {
                                  idLevel = e.levelId;
                                }
                              }).toList();
                            });
                          }),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "Languages: ",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.sp),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      height: 50.h,
                      width: 300.w,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                      child: buildDropdownButton(
                          value: sLanguage,
                          items: language.map((e) => e.languageName).toList(),
                          onChange: (String? newValue) {
                            setState(() {
                              sLanguage = newValue!;
                              language.map((e) {
                                if (e.languageName == newValue) {
                                  idLanguage = e.languageId;
                                }
                              }).toList();
                            });
                          }),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "Categories: ",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.sp),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      height: 50.h,
                      width: 300.w,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                      child: buildDropdownButton(
                          value: sType,
                          items: type.map((e) => e.categoryName).toList(),
                          onChange: (String? newValue) {
                            setState(() {
                              sType = newValue!;
                              type.map((e) {
                                if (e.categoryName == newValue) {
                                  idType = e.categoryId;
                                }
                              }).toList();
                            });
                          }),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 40.w,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0).w,
                child: SizedBox(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Question: ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          width: 800.w,
                          child: TextFormField(
                            maxLines: null,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the question';
                              }
                            },
                            controller: questionNameController,
                            style: TextStyle(
                                fontSize: 25.sp,
                                fontWeight: FontWeight.normal,
                                color: Colors.black87),
                            onSaved: (value) {
                              questionNameController.text = value!;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Ask question',
                              // Enabled Border
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              // Focused Border
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0).w,
                          child: Text(
                            "Options: ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              controllers.add(TextEditingController());
                              listNumber = List.generate(
                                  controllers.length, (i) => "${i + 1}");
                            });
                          },
                        ),
                        ...controllers.asMap().entries.map(
                              (entry) => Padding(
                                padding: const EdgeInsets.only(left: 30).w,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 700.w,
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter the option';
                                          }
                                        },
                                        style: TextStyle(
                                            fontSize: 25.sp,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black87),
                                        onSaved: (value) {
                                          entry.value.text = value!;
                                        },
                                        decoration: const InputDecoration(
                                          hintText: 'Add option',
                                          // Enabled Border
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue, width: 2),
                                          ),
                                        ),
                                        controller: entry.value,
                                      ),
                                    ),
                                    if (controllers.length > 2)
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () {
                                          setState(() {
                                            controllers.removeAt(entry.key);
                                            listNumber = List.generate(
                                                controllers.length,
                                                (i) => "${i + 1}");
                                          });
                                        },
                                      ),
                                  ],
                                ),
                              ),
                            ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                          children: [
                            Text(
                              "The correct answer is option number: ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 25.sp),
                            ),
                            Container(
                              width: 100.w,
                              height: 50.h,
                              child: buildDropdownButton(
                                  value: indexTrue,
                                  items: listNumber,
                                  onChange: (String? newValue) {
                                    setState(() {
                                      indexTrue = newValue!;
                                    });
                                  }),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Text(
                          "Description: ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          width: 800.w,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter description';
                              }
                            },
                            maxLines: null,
                            controller: descriptionController,
                            style: TextStyle(
                                fontSize: 25.sp,
                                fontWeight: FontWeight.normal,
                                color: Colors.black87),
                            onSaved: (value) {
                              descriptionController.text = value!;
                            },
                            decoration: const InputDecoration(
                              hintText: 'You can add description about answer',
                              // Enabled Border
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              // Focused Border
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        Center(
                          child: MyElevatedButton(
                            width: 220.w,
                            height: 50.h,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                List<OptionsQuestionEntity> optionsList = [];
                                for (int i = 0; i < controllers.length; i++) {
                                  optionsList.add(OptionsQuestionEntity(
                                      optionId: "",
                                      optionName: controllers[i].text,
                                      isTrue: i == (int.parse(indexTrue) - 1)
                                          ? true
                                          : false));
                                }
                                QuestionsEntity questionsEntity =
                                    QuestionsEntity(
                                        teacherId: "",
                                        firstNameTeacher: "",
                                        lastNameTeacher: "",
                                        descriptionAnswer:
                                            descriptionController.text,
                                        languagesTeacher: Language(
                                            languageId: idLanguage,
                                            languageName: sLanguage),
                                        isFollowingTeacher: false,
                                        isSolve: false,
                                        level: LevelContentEntity(
                                            levelId: idLevel,
                                            levelName: sLevel),
                                        questionId: "",
                                        questionName:
                                            questionNameController.text,
                                        categoryQuestion:
                                            CategoryQuestionEntity(
                                                categoryId: idType,
                                                categoryName: sType,
                                                languageId: idLanguage),
                                        optionsList: optionsList);
                                BlocProvider.of<QuestionsBloc>(context).add(
                                    CreateQuestionEvent(
                                        questionsEntity: questionsEntity));
                              }
                            },
                            child: BlocBuilder<QuestionsBloc, QuestionsState>(
                              builder: (context, state) {
                                if (state is CreateQuestionSuccess) {
                                  showToastWidgetSuccess("Create new question");
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Questions()));
                                  return Text(
                                    "Save Question",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold),
                                  );
                                }
                                if (state is CreateQuestionLoading) {
                                  return const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                }
                                if (state is CreateQuestionError) {
                                  showToastWidgetError("${state.message}");
                                }
                                return Text(
                                  "Save Question",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
