import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learny_project/features/auth/data/models/user_model.dart';
import 'package:learny_project/features/content/domain/usecases/posts/create_post_use_case.dart';
import 'package:learny_project/features/content/domain/usecases/posts/delete_post_use_case.dart';
import 'package:learny_project/features/content/domain/usecases/posts/get_all_posts_use_case.dart';
import 'package:learny_project/features/content/domain/usecases/posts/get_post_use_case.dart';
import 'package:learny_project/features/content/presentation/pages/paragraphs/paragraphs.dart';
import 'package:learny_project/features/content/presentation/pages/posts/posts_page.dart';
import 'package:learny_project/features/content/presentation/pages/questions/questions.dart';
import 'package:learny_project/features/teachers/presentation/widgets/becom_a_teacher_widgets/footer.dart';
import 'package:learny_project/injection_container.dart' as di;
import '../../../../core/error/exception.dart';
import '../../../auth/data/datasources/local_data_sources/auth_local_data_sources.dart';
import '../../../auth/presentation/pages/login/login.dart';
import '../../domain/usecases/posts/get_my_posts_use_case.dart';
import '../../domain/usecases/posts/get_type_posts_use_case.dart';
import '../bloc/posts/posts_bloc.dart';

class ContentPageHome extends StatefulWidget {
  ContentPageHome({Key? key, required this.userModel}) : super(key: key);
  UserModel? userModel;

  @override
  State<ContentPageHome> createState() => _ContentPageHomeState();
}

class _ContentPageHomeState extends State<ContentPageHome> {
  @override
  void initState() {
    _getUserInformation();
    super.initState();
  }

  final AuthLocalDataSources _authLocalDataSourcesImpl =
      di.sl<AuthLocalDataSources>();
  UserModel? userInformation;
  bool isVisibleQuestion = false;
  bool isVisibleParagraph = false;
  bool isVisiblePosts = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: EdgeInsets.all(6.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 250.w),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ///Questions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: isVisibleQuestion,
                          child: Transform(
                              transform: Matrix4.identity()
                                ..translate(100.0.w, -80.0.w),
                              child: Padding(
                                  padding: const EdgeInsets.all(10.0).w,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 60.h,
                                    child: CircleAvatar(
                                      radius: 55.h,
                                      backgroundColor: Colors.white,
                                      child: ClipOval(
                                        child: CircleAvatar(
                                          radius: 53.w,
                                          backgroundColor: Colors.white,
                                          child: SvgPicture.asset(
                                              "assets/images/undraw_exams_re_4ios.svg"),
                                        ),
                                      ),
                                    ),
                                  ))),
                        ),
                        Visibility(
                          visible: isVisibleQuestion,
                          child: Transform(
                              transform: Matrix4.identity()
                                ..translate(100.0.w, -210.w),
                              child: Padding(
                                  padding: const EdgeInsets.all(10.0).w,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 60.h,
                                    child: CircleAvatar(
                                      radius: 55.h,
                                      backgroundColor: Colors.white,
                                      child: ClipOval(
                                        child: CircleAvatar(
                                          radius: 53.w,
                                          backgroundColor: Colors.white,
                                          child: SvgPicture.asset(
                                              "assets/images/undraw_online_test_re_kyfx.svg"),
                                        ),
                                      ),
                                    ),
                                  ))),
                        ),
                        Column(
                          children: [
                            InkWell(
                              hoverColor: Colors.transparent,
                              onTap: () {
                                if (userInformation == null) {
                                  showCenterDialog(context);
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Questions()));
                                }
                                //     html.window.open('${html.window.location.href}questions', 'newtab');
                              },
                              onHover: (value) {
                                setState(() {
                                  isVisibleQuestion = value;
                                });
                              },
                              child: ClipOval(
                                child: CircleAvatar(
                                  radius: 150.w,
                                  child: SvgPicture.asset(
                                      "assets/images/undraw_questions_re_1fy7.svg"),
                                ),
                              ),
                            ),
                            Text(
                              "Question",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Visibility(
                          visible: isVisibleQuestion,
                          child: Transform(
                              transform: Matrix4.identity()
                                ..translate(-110.0.w, -210.w),
                              child: Padding(
                                  padding: const EdgeInsets.all(10.0).w,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 60.h,
                                    child: CircleAvatar(
                                      radius: 55.h,
                                      backgroundColor: Colors.white,
                                      child: ClipOval(
                                        child: CircleAvatar(
                                          radius: 53.h,
                                          backgroundColor: Colors.white,
                                          child: SvgPicture.asset(
                                              "assets/images/undraw_my_answer_re_k4dv.svg"),
                                        ),
                                      ),
                                    ),
                                  ))),
                        ),
                        Visibility(
                          visible: isVisibleQuestion,
                          child: Transform(
                              transform: Matrix4.identity()
                                ..translate(-110.0.w, -80.w),
                              child: Padding(
                                  padding: const EdgeInsets.all(10.0).w,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 60.h,
                                    child: CircleAvatar(
                                      radius: 55.h,
                                      backgroundColor: Colors.white,
                                      child: ClipOval(
                                        child: CircleAvatar(
                                          radius: 53.w,
                                          backgroundColor: Colors.white,
                                          child: SvgPicture.asset(
                                              "assets/images/undraw_searching_re_3ra9.svg"),
                                        ),
                                      ),
                                    ),
                                  ))),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 30.w,
                    ),

                    ///Paragraphs
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: isVisibleParagraph,
                          child: Transform(
                              transform: Matrix4.identity()
                                ..translate(100.0.w, -80.0.w),
                              child: Padding(
                                  padding: const EdgeInsets.all(10.0).w,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 60.h,
                                    child: CircleAvatar(
                                      radius: 55.h,
                                      backgroundColor: Colors.white,
                                      child: ClipOval(
                                        child: CircleAvatar(
                                          radius: 53.w,
                                          backgroundColor: Colors.white,
                                          child: SvgPicture.asset(
                                              "assets/images/undraw_speech_to_text_re_8mtf.svg"),
                                        ),
                                      ),
                                    ),
                                  ))),
                        ),
                        Visibility(
                          visible: isVisibleParagraph,
                          child: Transform(
                              transform: Matrix4.identity()
                                ..translate(100.0.w, -210.w),
                              child: Padding(
                                  padding: const EdgeInsets.all(10.0).w,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 60.h,
                                    child: CircleAvatar(
                                      radius: 55.h,
                                      backgroundColor: Colors.white,
                                      child: ClipOval(
                                        child: CircleAvatar(
                                          radius: 53.w,
                                          backgroundColor: Colors.white,
                                          child: SvgPicture.asset(
                                              "assets/images/undraw_online_everywhere_re_n3lr.svg"),
                                        ),
                                      ),
                                    ),
                                  ))),
                        ),
                        Column(
                          children: [
                            InkWell(
                              hoverColor: Colors.transparent,
                              onTap: () {
                                if (userInformation == null) {
                                  showCenterDialog(context);
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Paragraphs()));
                                }
                              },
                              onHover: (value) {
                                setState(() {
                                  isVisibleParagraph = value;
                                });
                              },
                              child: ClipOval(
                                child: CircleAvatar(
                                  radius: 150.w,
                                  backgroundColor: Colors.white,
                                  child: SvgPicture.asset(
                                      "assets/images/undraw_text_files_au1q.svg"),
                                ),
                              ),
                            ),
                            Text(
                              "Paragraphs",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Visibility(
                          visible: isVisibleParagraph,
                          child: Transform(
                              transform: Matrix4.identity()
                                ..translate(-110.0.w, -210.w),
                              child: Padding(
                                  padding: const EdgeInsets.all(10.0).w,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 60.h,
                                    child: CircleAvatar(
                                      radius: 55.h,
                                      backgroundColor: Colors.white,
                                      child: ClipOval(
                                        child: CircleAvatar(
                                          radius: 53.w,
                                          backgroundColor: Colors.white,
                                          child: SvgPicture.asset(
                                              "assets/images/undraw_podcast_re_wr88.svg"),
                                        ),
                                      ),
                                    ),
                                  ))),
                        ),
                        Visibility(
                          visible: isVisibleParagraph,
                          child: Transform(
                              transform: Matrix4.identity()
                                ..translate(-110.0.w, -80.w),
                              child: Padding(
                                  padding: const EdgeInsets.all(10.0).w,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 60.h,
                                    child: CircleAvatar(
                                      radius: 55.h,
                                      backgroundColor: Colors.white,
                                      child: ClipOval(
                                        child: CircleAvatar(
                                          radius: 53.w,
                                          backgroundColor: Colors.white,
                                          child: SvgPicture.asset(
                                              "assets/images/undraw_listening_re_c2w0.svg"),
                                        ),
                                      ),
                                    ),
                                  ))),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 30.w,
                    ),

                    ///Posts
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: isVisiblePosts,
                          child: Transform(
                              transform: Matrix4.identity()
                                ..translate(100.0.w, -80.0.w),
                              child: Padding(
                                  padding: const EdgeInsets.all(10.0).w,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 60.h,
                                    child: CircleAvatar(
                                      radius: 55.h,
                                      backgroundColor: Colors.white,
                                      child: ClipOval(
                                        child: CircleAvatar(
                                          radius: 53.w,
                                          backgroundColor: Colors.white,
                                          child: SvgPicture.asset(
                                              "assets/images/undraw_online_media_re_r9qv.svg"),
                                        ),
                                      ),
                                    ),
                                  ))),
                        ),
                        Visibility(
                          visible: isVisiblePosts,
                          child: Transform(
                              transform: Matrix4.identity()
                                ..translate(100.0.w, -210.w),
                              child: Padding(
                                  padding: const EdgeInsets.all(10.0).w,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 60.h,
                                    child: CircleAvatar(
                                      radius: 55.h,
                                      backgroundColor: Colors.white,
                                      child: ClipOval(
                                        child: CircleAvatar(
                                          radius: 53.w,
                                          backgroundColor: Colors.white,
                                          child: SvgPicture.asset(
                                              "assets/images/undraw_image_viewer_re_7ejc.svg"),
                                        ),
                                      ),
                                    ),
                                  ))),
                        ),
                        Column(
                          children: [
                            InkWell(
                              hoverColor: Colors.transparent,
                              onTap: () {
                                if (userInformation == null) {
                                  showCenterDialog(context);
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PostsPage()));
                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>BlocProvider(create: (context) => PostsBloc(getTypePostsUseCase: di.sl<GetTypePostsUseCase>(), createPostUseCase: di.sl<CreatePostUseCase>(), deletePostUseCase: di.sl<DeletePostUseCase>(), getAllPostsUseCase: di.sl<GetAllPostsUseCase>(), getMyPostsUseCase: di.sl<GetMyPostsUseCase>(), getPostUseCase: di.sl<GetPostUseCase>()),child: PostsPage(),)));
                                }
                              },
                              onHover: (value) {
                                setState(() {
                                  isVisiblePosts = value;
                                });
                              },
                              child: ClipOval(
                                child: CircleAvatar(
                                  radius: 150.w,
                                  backgroundColor: Colors.white,
                                  child: SvgPicture.asset(
                                      "assets/images/undraw_browsing_online_re_umsa.svg"),
                                ),
                              ),
                            ),
                            Text(
                              "Posts",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Visibility(
                          visible: isVisiblePosts,
                          child: Transform(
                              transform: Matrix4.identity()
                                ..translate(-110.0.w, -210.w),
                              child: Padding(
                                  padding: const EdgeInsets.all(10.0).w,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 60.h,
                                    child: CircleAvatar(
                                      radius: 55.h,
                                      backgroundColor: Colors.white,
                                      child: ClipOval(
                                        child: CircleAvatar(
                                          radius: 53.w,
                                          backgroundColor: Colors.white,
                                          child: SvgPicture.asset(
                                              "assets/images/undraw_mobile_posts_re_bpuw.svg"),
                                        ),
                                      ),
                                    ),
                                  ))),
                        ),
                        Visibility(
                          visible: isVisiblePosts,
                          child: Transform(
                              transform: Matrix4.identity()
                                ..translate(-110.0.w, -80.w),
                              child: Padding(
                                  padding: const EdgeInsets.all(10.0).w,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 60.h,
                                    child: CircleAvatar(
                                      radius: 55.h,
                                      backgroundColor: Colors.white,
                                      child: ClipOval(
                                        child: CircleAvatar(
                                          radius: 53.w,
                                          backgroundColor: Colors.white,
                                          child: SvgPicture.asset(
                                              "assets/images/undraw_book_lover_re_rwjy.svg"),
                                        ),
                                      ),
                                    ),
                                  ))),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 70.h,
              ),
              footer(context)
            ],
          ),
        ),
      ),
    ));
  }

  void showCenterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Login()),
        );
      },
    );
  }

  Future<void> _getUserInformation() async {
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
