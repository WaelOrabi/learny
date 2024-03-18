import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learny_project/features/content/presentation/pages/posts/post_image.dart';
import 'package:learny_project/features/content/presentation/pages/posts/post_pdf.dart';
import 'package:learny_project/features/content/presentation/pages/posts/post_text.dart';
import 'package:learny_project/features/content/presentation/pages/posts/post_video.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "Posts",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold),
              ),
              bottom: TabBar(
                tabs: [
                  Tab(
                      child: Text(
                        "Videos",
                        style: TextStyle(color: Colors.black, fontSize: 25.sp),
                      )),
                  Tab(
                      child: Text(
                        "Photos",
                        style: TextStyle(color: Colors.black, fontSize: 25.sp),
                      )),
                 Tab(
                    child: Text(
                      "Texts",
                      style: TextStyle(color: Colors.black, fontSize: 25.sp),
                    ),
                  ),
                  Tab(
                      child: Text(
                        "PDFs",
                        style: TextStyle(color: Colors.black, fontSize: 25.sp),
                      )),


                ],
              ),
            ),
            body:  const TabBarView(
              children: [
                PostVideo(),
                PostImage(),
                PostText(),
                PostPDF(),

              ],
            ),
          )),
    );
  }
}
