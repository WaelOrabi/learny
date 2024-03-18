import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvailableTime extends StatelessWidget {
  final String hour;
  final VoidCallback onTap;
  final bool isSelected;

  const AvailableTime({
    Key? key,
    required this.hour,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10).w,
        padding: const EdgeInsets.all(10).w,
        height: 60.h,
        width: 90.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.black26,
          borderRadius: BorderRadius.circular(10).w,
        ),
        child: Text(
          hour,
          style: TextStyle(color: Colors.white, fontSize: 20.sp),
        ),
      ),
    );
  }
}

