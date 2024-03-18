import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../auth/presentation/widgets/ElvatedButtonWdget.dart';

Widget getStartOfBecome({required GlobalKey personalInfoKey,required ScrollController scrollController}) {
  return Align(
    alignment: Alignment.center,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  "\"One teacher can \n\n change the lives of \n\n students forever.\"",
                  style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 40.h,
                ),
                TextButton(
                  onPressed:()=>  scrollToPersonalInfo(personalInfoKey: personalInfoKey,scrollController: scrollController) ,
                  child: MyElevatedButton(
                    width: 220.w,
                    height: 50.h,
                    onPressed: () {
                      scrollToPersonalInfo(personalInfoKey: personalInfoKey,scrollController: scrollController);
                    },
                    child: Text(
                      "Get Started >",
                      style: TextStyle(color: Colors.white, fontSize: 20.sp,fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 600.h,
            width: 400.w,
            child: Image.asset("assets/images/teacher.png"),
          ),
        ],
      ),
    ),
  );
}



void scrollToPersonalInfo({required GlobalKey personalInfoKey,required ScrollController scrollController}) {
  final RenderBox? renderBox =
  personalInfoKey.currentContext?.findRenderObject() as RenderBox?;
  if (renderBox != null) {
    final offset = renderBox.localToGlobal(Offset.zero);
    final scrollOffset = offset.dy - 100.h;
    scrollController.animateTo(
      scrollOffset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}