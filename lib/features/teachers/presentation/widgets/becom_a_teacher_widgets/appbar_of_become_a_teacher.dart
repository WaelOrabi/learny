

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget appbarOfBecome() {
  return Container(
    padding: const EdgeInsets.all(30).w,
    width: double.infinity,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xff16D9E3),
          Color(0xff30C7EC),
          Color(0xff46AEF7),
        ],
      ),
    ),
    child:  Center(
      child: Text(
        "Become a Teacher",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30.sp,
        ),
      ),
    ),
  );
}