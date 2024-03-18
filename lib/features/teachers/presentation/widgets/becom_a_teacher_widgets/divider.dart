import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget divider(double size) {
  return Column(
    children: [
      SizedBox(
        height: size,
      ),
      Divider(
        indent: 20.h,
        endIndent: 20.h,
        height: 5.h,
      ),
    ],
  );
}