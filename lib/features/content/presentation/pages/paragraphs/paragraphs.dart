import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learny_project/features/content/presentation/bloc/paragraphs/paragraphs_bloc.dart';
import 'package:learny_project/features/content/presentation/pages/paragraphs/speech_to_text.dart';
import 'package:learny_project/features/content/presentation/pages/paragraphs/stories_paragraphs.dart';
import 'package:learny_project/features/content/presentation/pages/paragraphs/text_to_speech.dart';

import '../../../../admin/presentation/bloc/language_bloc/language_bloc.dart';
import '../../bloc/content/content_bloc.dart';

class Paragraphs extends StatefulWidget {
  const Paragraphs({Key? key}) : super(key: key);

  @override
  State<Paragraphs> createState() => _ParagraphsState();
}

class _ParagraphsState extends State<Paragraphs> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Paragraphs",
            style: TextStyle(
                color: Colors.blue,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  "Stories",
                  style: TextStyle(color: Colors.black, fontSize: 25.sp),
                ),
              ),
              Tab(
                  child: Text(
                "Text to speech",
                style: TextStyle(color: Colors.black, fontSize: 25.sp),
              )),
              Tab(
                  child: Text(
                "Speech to text",
                style: TextStyle(color: Colors.black, fontSize: 25.sp),
              )),
            ],
          ),
        ),
        body:  TabBarView(
          children: [
           StoriesParagraphs(),
           TextToSpeechScreen(),
            SpeechToTextScreen(),
          ],
        ),
      )),
    );
  }
}
