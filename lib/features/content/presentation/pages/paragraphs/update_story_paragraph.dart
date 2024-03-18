import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../auth/presentation/widgets/ElvatedButtonWdget.dart';
import '../../../../teachers/presentation/widgets/becom_a_teacher_widgets/build_drop_down_button.dart';

class UpdateStoryParagraph extends StatefulWidget {
  const UpdateStoryParagraph({Key? key,required this.paragraphId}) : super(key: key);
final String paragraphId;
  @override
  State<UpdateStoryParagraph> createState() => _UpdateStoryParagraphState();
}

class _UpdateStoryParagraphState extends State<UpdateStoryParagraph> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController storyController = TextEditingController();
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
                "Update Paragraph",
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
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                              onPressed: () {},
                              child: Text(
                                "Save paragraph",
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
            ),
          )),
    );
  }
}
