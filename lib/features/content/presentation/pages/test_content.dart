import 'package:flutter/material.dart';
import 'package:learny_project/features/content/presentation/pages/paragraphs/add_story_paragraph.dart';
import 'package:learny_project/features/content/presentation/pages/paragraphs/my_stories_paragraphs.dart';
import 'package:learny_project/features/content/presentation/pages/questions/add_questions.dart';
import 'package:learny_project/features/content/presentation/pages/questions/my_questions.dart';

class TestContent extends StatefulWidget {
  const TestContent({Key? key}) : super(key: key);

  @override
  State<TestContent> createState() => _TestContentState();
}

class _TestContentState extends State<TestContent> {
  @override
  Widget build(BuildContext context) {
    return  Column(children: [
      TextButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyQuestions()));
      }, child: Text("My Questions")),
      SizedBox(height: 20,),

      TextButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddQuestions()));
      }, child: Text("Add Question")),
      SizedBox(height: 20,),
      TextButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyStoriesParagraphs()));
      }, child: Text("My Paragraphs")),
      SizedBox(height: 20,),
      TextButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddStoryParagraph()));
      }, child: Text("add Paragraphs")),
      SizedBox(height: 20,),
    ],);
  }
}
