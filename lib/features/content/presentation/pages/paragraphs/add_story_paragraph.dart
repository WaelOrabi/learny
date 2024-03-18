import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learny_project/features/content/domain/entities/category_paragraph.dart';
import 'package:learny_project/features/content/domain/entities/paragraphs_entity.dart';
import 'package:learny_project/features/content/presentation/bloc/paragraphs/paragraphs_bloc.dart';
import 'package:learny_project/features/content/presentation/pages/paragraphs/paragraphs.dart';
import '../../../../../core/widgets/toast_widget.dart';
import '../../../../admin/domain/entities/language_entity.dart';
import '../../../../admin/presentation/bloc/language_bloc/language_bloc.dart';
import '../../../../auth/presentation/widgets/ElvatedButtonWdget.dart';
import '../../../../teachers/presentation/widgets/becom_a_teacher_widgets/build_drop_down_button.dart';
import '../../../domain/entities/level_content.dart';
import '../../bloc/content/content_bloc.dart';

class AddStoryParagraph extends StatefulWidget {
  const AddStoryParagraph({Key? key}) : super(key: key);

  @override
  State<AddStoryParagraph> createState() => _AddStoryParagraphState();
}

class _AddStoryParagraphState extends State<AddStoryParagraph> {

  @override
  void initState() {
    BlocProvider.of<LanguageBloc>(context).add(GetAllLanguagesEvent());
    BlocProvider.of<ContentBloc>(context).add(GetLevelsContentEvent());
    BlocProvider.of<ContentBloc>(context).add(GetCategoriesParagraphEvent());
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController storyController = TextEditingController();

  List<Language> language = [
    Language(languageId: "1", languageName: "English")
  ];

  List<LevelContentEntity> level = [
    LevelContentEntity(levelId: "1", levelName: "Easy")
  ];
  List<CategoryParagraphEntity> type = [
    CategoryParagraphEntity(
      categoryId: "1",
      categoryName: "Scientific",
    )
  ];

  String sLanguage = "English";
  String idLanguage = "1";
  String sType = "Scientific";
  String idType = "1";
  String sLevel = "Easy";
  String idLevel = "1";

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
          if (state is GetCategoriesParagraphSuccess) {
            type = state.listCategoryParagraphEntity;
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
              "Add Paragraph",
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
                          "Story: ",
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
                                return 'Please enter the paragraph';
                              }
                            },
                            controller: storyController,
                            style: TextStyle(
                                fontSize: 25.sp,
                                fontWeight: FontWeight.normal,
                                color: Colors.black87),
                            onSaved: (value) {
                              storyController.text = value!;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Write your paragraph',
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
                        Center(
                          child: MyElevatedButton(
                            width: 220.w,
                            height: 50.h,
                            onPressed: () {
                              ParagraphsEntity paragraphsEntity =
                                  ParagraphsEntity(
                                      teacherId: "",
                                      firstNameTeacher: "",
                                      lastNameTeacher: "",
                                      languageParagraph: Language(
                                          languageId: idLanguage,
                                          languageName: sLanguage),
                                      isFollowingTeacher: false,
                                      level: LevelContentEntity(
                                          levelId: idLevel, levelName: sLevel),
                                      paragraphId: "",
                                      paragraphName: storyController.text,
                                      categoryParagraph:
                                          CategoryParagraphEntity(
                                              categoryId: idType,
                                              categoryName: sType));
                              BlocProvider.of<ParagraphsBloc>(context).add(
                                  CreateParagraphEvent(
                                      paragraphsEntity: paragraphsEntity));
                            },
                            child: BlocBuilder<ParagraphsBloc, ParagraphsState>(
                              builder: (context, state) {
                                if (state is CreateParagraphSuccess) {

                                  showToastWidgetSuccess("Create new paragraph");
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Paragraphs()));

                                  return Text(
                                    "Save Paragraph",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold),
                                  );

                                }
                                if (state is CreateParagraphLoading) {
                                  return  Padding(
                                    padding: const EdgeInsets.all(8.0).w,
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                }
                                if (state is CreateParagraphError) {
                                  showToastWidgetError("${state.message}");
                                  return Text(
                                    "Save Paragraph",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold),
                                  );

                                }
                                return Padding(
                                  padding: const EdgeInsets.all(8.0).w,
                                  child: Text(
                                    "Save Paragraph",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
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
