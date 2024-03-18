import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learny_project/core/widgets/toast_widget.dart';
import 'package:learny_project/features/auth/presentation/widgets/ElvatedButtonWdget.dart';
import 'package:learny_project/features/content/domain/entities/level_content.dart';
import 'package:learny_project/features/content/domain/entities/posts_entity.dart';
import 'package:learny_project/features/content/domain/entities/type_posts_entity.dart';
import 'package:learny_project/features/content/presentation/bloc/posts/posts_bloc.dart';
import 'package:learny_project/features/content/presentation/pages/posts/posts_page.dart';
import '../../../../../core/constants.dart';
import '../../../../admin/domain/entities/language_entity.dart';
import '../../../../admin/presentation/bloc/language_bloc/language_bloc.dart';
import '../../../../teachers/presentation/widgets/becom_a_teacher_widgets/build_drop_down_button.dart';
import '../../bloc/content/content_bloc.dart';
import '../../widgets/posts/add_pdf_post.dart';
import '../../widgets/posts/add_video_post.dart';

class AddPosts extends StatefulWidget {
  const AddPosts({Key? key}) : super(key: key);

  @override
  State<AddPosts> createState() => _AddPostsState();
}

class _AddPostsState extends State<AddPosts> {
  @override
  void initState() {
    BlocProvider.of<LanguageBloc>(context).add(GetAllLanguagesEvent());
    BlocProvider.of<ContentBloc>(context).add(GetLevelsContentEvent());
    super.initState();
  }

  final TextEditingController postTextTitleController = TextEditingController();
  final TextEditingController postTextDescriptionController =
      TextEditingController();
  final TextEditingController postImageDescriptionController =
      TextEditingController();
  final TextEditingController postImageTextController = TextEditingController();
  final TextEditingController postVideoTextController = TextEditingController();
  final TextEditingController postVideoDescriptionController =
      TextEditingController();
  final TextEditingController postPDFTitleController = TextEditingController();
  final TextEditingController postPDFDescriptionController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _typeOfPost = "Text";
  List<Language> listLanguages = [];
  List<LevelContentEntity> listLevel = [];
  String sLanguage = "English";
  String idLanguage = "1";
  String sLevel = "Easy";
  String idLevel = "1";

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LanguageBloc, LanguageState>(listener: (context, state) {
          if (state is GetAllLanguagesSuccessState) {
            setState(() {
              listLanguages = state.listAllLanguages;
            }

            );
          }
        }),
        BlocListener<ContentBloc, ContentState>(listener: (context, state) {
          if (state is GetLevelsContentSuccess) {
            setState(() {
              listLevel = state.listLevelContentEntity;
            });
          }
        }),
      ],
      child: Form(
        key: _formKey,
        child: SafeArea(
            child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Add post",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Select type of post: ",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.sp),
                  ),
                  SizedBox(
                    height: 20.h,
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
                    child: buildDropdownButton(
                        value: _typeOfPost,
                        items: ["Text", "Photo", "Video", "PDF"],
                        onChange: (String? newValue) {
                          setState(() {
                            _typeOfPost = newValue!;
                          });
                        }),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Select language of post: ",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.sp),
                  ),
                  SizedBox(
                    height: 20.h,
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
                    child: buildDropdownButton(
                        value: sLanguage,
                        items: listLanguages.map((e) => e.languageName).toList(),
                        onChange: (String? newValue) {
                          setState(() {
                            sLanguage = newValue!;
                          });
                        }),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Select level of post: ",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.sp),
                  ),
                  SizedBox(
                    height: 20.h,
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
                    child: buildDropdownButton(
                        value: sLevel,
                        items: listLevel.map((e) => e.levelName).toList(),
                        onChange: (String? newValue) {
                          setState(() {
                            sLevel = newValue!;
                          });
                        }),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  if (_typeOfPost == "Text") _buildText(context),
                  if (_typeOfPost == "Photo") _buildImage(context),
                  if (_typeOfPost == "Video") _buildVideo(context),
                  if (_typeOfPost == "PDF")
                    AddPdfPostScreen(
                      postPDFTitleController: postPDFTitleController,
                      postPDFDescriptionController: postPDFDescriptionController,
                    ),
                  SizedBox(
                    height: 30.h,
                  ),
                  MyElevatedButton(onPressed: () async {
                    listLanguages.map((e) {
                      if (e.languageName == sLanguage) {
                        idLanguage = e.languageId;
                      }
                    }).toList();
                    listLevel.map((e) {
                      if (e.levelName == sLevel) {
                        idLevel = e.levelId;
                      }
                    }).toList();

                    if (_typeOfPost == "Text") {
                      PostsEntity postsEntityText = PostsEntity(
                          teacherId: "",
                          firstNameTeacher: "",
                          lastNameTeacher: "",
                          languagesTeacher: Language(
                              languageId: idLanguage, languageName: sLanguage),
                          timePost: "",
                          isFollowingTeacher: false,
                          level: LevelContentEntity(
                              levelId: idLevel, levelName: sLevel),
                          postId: "",
                          postName: "",
                          postTitle: postTextTitleController.text,
                          description: postTextDescriptionController.text,
                          typePostsEntity:
                              TypePostsEntity(typeId: "3", typeName: "text"));
                      BlocProvider.of<PostsBloc>(context)
                          .add(CreatePostEvent(postsEntity: postsEntityText));
                    } else if (_typeOfPost == "Video") {
                      PostsEntity postsEntityVideo = PostsEntity(
                          teacherId: "",
                          firstNameTeacher: "",
                          lastNameTeacher: "",
                          languagesTeacher: Language(
                              languageId: idLanguage, languageName: sLanguage),
                          timePost: "",
                          isFollowingTeacher: false,
                          level: LevelContentEntity(
                              levelId: idLevel, levelName: sLevel),
                          postId: "",
                          postName:
                              BlocProvider.of<PostsBloc>(context).videoBase64,
                          postTitle: postVideoTextController.text,
                          description: postVideoDescriptionController.text,
                          typePostsEntity:
                              TypePostsEntity(typeId: "1", typeName: "video"));
                      BlocProvider.of<PostsBloc>(context)
                          .add(CreatePostEvent(postsEntity: postsEntityVideo));
                    } else if (_typeOfPost == "Photo") {


                      List<int> imageFrontBytes =
                      await BlocProvider.of<PostsBloc>(context)
                          .imagePost!
                          .readAsBytes();
                      String imageFront = base64Encode(imageFrontBytes);
                      String imageBase64 =
                          "data:image/${BlocProvider.of<PostsBloc>(context).imagePost!.name.split(".").last};base64,$imageFront";
                      PostsEntity postsEntityImage = PostsEntity(
                          teacherId: "",
                          firstNameTeacher: "",
                          lastNameTeacher: "",
                          languagesTeacher: Language(
                              languageId: idLanguage, languageName: sLanguage),
                          timePost: "",
                          isFollowingTeacher: false,
                          level: LevelContentEntity(
                              levelId: idLevel, levelName: sLevel),
                          postId: "",
                          postName: imageBase64,
                          postTitle: postImageTextController.text,
                          description: postImageDescriptionController.text,
                          typePostsEntity:
                              TypePostsEntity(typeId: "2", typeName: "Photos"));
                      BlocProvider.of<PostsBloc>(context)
                          .add(CreatePostEvent(postsEntity: postsEntityImage));
                    } else if (_typeOfPost == "PDF") {
                      PostsEntity postsEntityPdf = PostsEntity(
                          teacherId: "",
                          firstNameTeacher: "",
                          lastNameTeacher: "",
                          languagesTeacher: Language(
                              languageId: idLanguage, languageName: sLanguage),
                          timePost: "",
                          isFollowingTeacher: false,
                          level: LevelContentEntity(
                              levelName: sLevel, levelId: idLevel),
                          postId: "",
                          postName: BlocProvider.of<PostsBloc>(context).pdfBase64,
                          postTitle: postPDFTitleController.text,
                          description: postPDFDescriptionController.text,
                          typePostsEntity:
                              TypePostsEntity(typeId: "4", typeName: "PDF"));

                      BlocProvider.of<PostsBloc>(context)
                          .add(CreatePostEvent(postsEntity: postsEntityPdf));
                    }
                  }, child: BlocBuilder<PostsBloc, PostsState>(
                      builder: (context, state) {
                    if (state is CreatePostError) {
                      showToastWidgetError("Please add later");
                      return Text(
                        "Save post",
                        style: TextStyle(color: Colors.white, fontSize: 25.sp),
                      );
                    } else if (state is CreatePostLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                      );
                    } else if (state is CreatePostSuccess) {
    Future.delayed(Duration.zero, () {
      Navigator.pop(context);

    showToastWidgetSuccess("Add new success");
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => PostsPage()));
                      return Text(
                        "Save post",
                        style: TextStyle(color: Colors.white, fontSize: 25.sp),
                      );
    });
                    }
                    return Text(
                      "Save post",
                      style: TextStyle(color: Colors.white, fontSize: 25.sp),
                    );
                  }))
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Post text: ",
            style: TextStyle(
                color: Colors.black,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            width: 400.w,
            child: TextFormField(
              maxLines: null,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the title';
                }
              },
              controller: postTextTitleController,
              style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.black87),
              onSaved: (value) {
                postTextTitleController.text = value!;
              },
              decoration: const InputDecoration(
                hintText: 'Write title your post',
                // Enabled Border
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                // Focused Border
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
            ),
          ),
          Container(
            width: 800.w,
            child: TextFormField(
              maxLines: null,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the description post';
                }
              },
              controller: postTextDescriptionController,
              style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.black87),
              onSaved: (value) {
                postTextDescriptionController.text = value!;
              },
              decoration: const InputDecoration(
                hintText: 'Write your post.',
                // Enabled Border
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                // Focused Border
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Post Photo: ",
            style: TextStyle(
                color: Colors.black,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            width: 400.w,
            child: TextFormField(
              maxLines: null,
              controller: postImageTextController,
              style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.black87),
              onSaved: (value) {
                postImageTextController.text = value!;
              },
              decoration: const InputDecoration(
                hintText: 'Write title about photo.',
                // Enabled Border
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                // Focused Border
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
            ),
          ),
          Container(
            width: 800.w,
            child: TextFormField(
              maxLines: null,
              controller: postImageDescriptionController,
              style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.black87),
              onSaved: (value) {
                postImageDescriptionController.text = value!;
              },
              decoration: const InputDecoration(
                hintText: 'Write description about your photo.',
                // Enabled Border
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                // Focused Border
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Stack(
            children: [
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
                    child: InkWell(
                        onTap: () =>
                            context.read<PostsBloc>().add(PickImagePostEvent()),
                        child: BlocBuilder<PostsBloc, PostsState>(
                            builder: (context, state) {
                          if (BlocProvider.of<PostsBloc>(context).imagePost ==
                              null) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                color: Colors.transparent,
                                child: const Icon(
                                  Icons.add_photo_alternate_outlined,
                                  size: 50,
                                ),
                              ),
                            );
                          } else {
                            return kIsWeb
                                ? Image.network(
                                    File(BlocProvider.of<PostsBloc>(context)
                                            .imagePost!
                                            .path)
                                        .path,
                                    fit: BoxFit.fill,
                                  )
                                : Image.file(
                                    File(BlocProvider.of<PostsBloc>(context)
                                        .imagePost!
                                        .path),
                                    fit: BoxFit.fill,
                                  );
                          }
                        }))),
              ),
              Positioned(
                  top: 5,
                  right: 5,
                  child: IconButton(
                      onPressed: () =>
                          context.read<PostsBloc>().add(PickImagePostEvent()),
                      icon: Icon(Icons.edit))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVideo(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Post Video: ",
            style: TextStyle(
                color: Colors.black,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            width: 400.w,
            child: TextFormField(
              maxLines: null,
              controller: postVideoTextController,
              style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.black87),
              onSaved: (value) {
                postVideoTextController.text = value!;
              },
              decoration: const InputDecoration(
                hintText: 'Write title about your video.',
                // Enabled Border
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                // Focused Border
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
            ),
          ),
          Container(
            width: 800.w,
            child: TextFormField(
              maxLines: null,
              controller: postVideoDescriptionController,
              style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.black87),
              onSaved: (value) {
                postVideoDescriptionController.text = value!;
              },
              decoration: const InputDecoration(
                hintText: 'Write description about your video.',
                // Enabled Border
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                // Focused Border
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          const AddVideoPost(),
          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }
}
