import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learny_project/features/content/presentation/bloc/questions/questions_bloc.dart';
import '../../../../auth/presentation/widgets/ElvatedButtonWdget.dart';
import '../../../../teachers/presentation/widgets/becom_a_teacher_widgets/build_drop_down_button.dart';

class UpdateQuestions extends StatefulWidget {
  const UpdateQuestions({Key? key, required this.questionId}) : super(key: key);
  final String questionId;

  @override
  State<UpdateQuestions> createState() => _UpdateQuestionsState();
}

class _UpdateQuestionsState extends State<UpdateQuestions> {
  @override
  void initState() {
    BlocProvider.of<QuestionsBloc>(context)
        .add(GetQuestionEvent(questionId: widget.questionId));
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.5,
          title: Text(
            "Update question",
            style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
                color: Colors.blue),
          ),
        ),
        body: BlocBuilder<QuestionsBloc, QuestionsState>(
          builder: (context, state) {
            if (state is GetQuestionSuccess) {
              return Row(
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
                              value: "Hard",
                              items: ["Hard", "Hi", "Hiirer"],
                              onChange: (String? newValue) {}),
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
                              value: "English",
                              items: ["English", "Hi", "Hiirer"],
                              onChange: (String? newValue) {}),
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
                              value: "Grammar",
                              items: ["Grammar", "Hi", "Hiirer"],
                              onChange: (String? newValue) {}),
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
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2),
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
                              icon: Icon(Icons.add),
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
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.blue,
                                                    width: 2),
                                              ),
                                            ),
                                            controller: entry.value,
                                          ),
                                        ),
                                        if (controllers.length > 2)
                                          IconButton(
                                            icon: Icon(Icons.remove),
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
                                      value: listNumber[0],
                                      items: listNumber,
                                      onChange: (String? newValue) {}),
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
                                  hintText:
                                      'You can add description about answer',
                                  // Enabled Border
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  // Focused Border
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2),
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
                                onPressed: () {},
                                child: Text(
                                  "Save Question",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            } else
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
          },
        ),
      )),
    );
  }
}
